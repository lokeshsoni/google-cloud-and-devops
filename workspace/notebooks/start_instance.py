import pandas as pd
import subprocess

import os
clear = lambda: os.system('clear')

def instances_group(data):
    indices = [index for index, value in enumerate(data) if value == "TERMINATED" or value == "RUNNING"]
    
    start_index = 0
    end_index = 0   
    
    chunks = []

    for index, index_value in enumerate(indices):
        end_index = index_value + 1
        
        instances = data[start_index:end_index]
        instances.insert(3, False)
        
        if len(instances) == 6:
            instances.insert(-1, "UNASSIGNED")
        
        chunks.append(instances)
        start_index = end_index
        
    return chunks

def get_instances():
    cmd = "gcloud compute instances list"
    
    output = subprocess.check_output(cmd, shell=True)
    output = output.decode("utf-8")
    output = output.split()
    
    columns = output[:7]
    data = output[7:]
    
    chunks = instances_group(data)
    instances = pd.DataFrame(chunks, columns=columns)
    
    return instances

instances = get_instances()

def choose_instance(instance_state):
    if instance_state == "start":
        instances_names = instances[instances["STATUS"] == "TERMINATED"]
    elif instance_state == "quit":
        return None
    else:
        instances_names = instances[instances["STATUS"] == "RUNNING"]
        
    instances_names = instances_names["NAME"].values.tolist()    
    instances_names = {index + 1 : instance_name for index, instance_name in enumerate(instances_names)}

    instance_name = None
    while True:
        if len(instances_names) > 0:       
            output = clear()
            print("please choose one of the options below")

            for index in instances_names:
                print(index, instances_names[index])

            try:
                choose_option = int(input("enter your choice : "))
            except:
                print("please choose a number from the above options")
                continue

            if choose_option in instances_names.keys():
                instance_name = instances_names[choose_option]
                break
            else:
                print("please choose a number from the above options")
                continue
        else:
            break

    return instance_name

instances_state = {1 : "start", 2 : "stop", 3 : "console", 4 : "quit"}

def process_instance(instance_state, instance_name):
    if not instance_state == "quit":
        zone = instances[instances["NAME"] == instance_name]["ZONE"].values.tolist()[0]

        if instance_state in ["start", "stop"]:    
            cmd = f'gcloud compute instances {instance_state} {instance_name} --zone {zone}'
        else:
            cmd = f'gcloud compute ssh {instance_name} --zone {zone} -- -L 8080:localhost:8080'

        output = subprocess.check_output(cmd, shell=True)

    
while True:
    output = clear()
    print("please choose one of the options below")
    
    for index in instances_state:
        print(index, instances_state[index])
        
    try:
        choose_option = int(input("enter your choice : "))
    except:
        print("please choose a number from the above options")
        continue
        
    if choose_option in instances_state.keys():
        if choose_option == 4:
            print("exiting the script")
            break
        
        instance_state = instances_state[choose_option]
        instance_name = choose_instance(instance_state)
        
        if instance_name:
            if choose_option == 1:
                output = process_instance(instance_state, instance_name)                
                # TODO : prompt for taking console
            elif choose_option == 2:
                output = process_instance(instance_state, instance_name)
            elif choose_option == 3:
                output = process_instance(instance_state, instance_name)
            print("process completed, thank you!")
            break
        else:
            print(f'sorry no instances to {instance_state}')
            break
    else:
        print("please choose a number from the above options")
        continue