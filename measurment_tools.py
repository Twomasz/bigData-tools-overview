from functools import wraps
from time import perf_counter
from typing import Callable, Any


def perf_timer(func: Callable) -> Callable:
    """
    Decorator to measure the performance of a function.
    """

    @wraps(func)
    def wrapper(*args, **kwargs) -> Any:
        """
        Wrapper function that measures the time taken by the decorated function.
        """
        start = perf_counter()
        result = func(*args, **kwargs)
        end = perf_counter()
        total_time_sec = end - start
        print(f"Function '{func.__name__}' took {total_time_sec:.5f} seconds to execute.")
        if total_time_sec > 60:
            print(f"Human-readable time: {total_time_sec // 60}mins {total_time_sec % 60}secs")
        return result

    return wrapper
