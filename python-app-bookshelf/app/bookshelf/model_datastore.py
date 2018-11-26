from flask import current_app
from google.cloud import datastore

def init_app(app):
    pass

def get_client():
    return datastore.Client(current_app.config['PROJECT_ID'])

def from_datastore(entity):
    if not entity:
        return None
    if isinstance(entity, list):
        entity = entity.pop()

    entity['id'] = entity.key.id
    return entity


def list(limit=10, cursor=None):
    ds = get_client()

    query = ds.query(kind='Book', order=['title'])
    query_iterator = query.fetch(limit=limit, start_cursor=cursor)
    page = next(query_iterator.pages)

    entities = list(map(from_datastore, page))
    
    next_cursor = None
    if query_iterator.next_page_token:
        next_cursor = query_iterator.next_page_token.decode('utf-8')

    return entities, next_cursor


def read(id):
    ds = get_client()
    key = ds.key('Book', int(id))
    results = ds.get(key)
    return from_datastore(results)


# [START update]
def update(data, id=None):
    ds = get_client()
    if id:
        key = ds.key('Book', int(id))
    else:
        key = ds.key('Book')

    entity = datastore.Entity(
        key=key,
        exclude_from_indexes=['description'])

    entity.update(data)
    ds.put(entity)
    return from_datastore(entity)


create = update
# [END update]


def delete(id):
    ds = get_client()
    key = ds.key('Book', int(id))
    ds.delete(key)
