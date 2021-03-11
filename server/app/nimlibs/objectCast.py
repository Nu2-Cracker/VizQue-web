def default_method(item):
    if isinstance(item, object) and hasattr(item, '__str__'):
        return str(item)
    else:
        return item