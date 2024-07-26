#!/bin/bash
greet_person() {
    local name=$1  # Assign the first parameter to a local variable 'name'
    local age=$2   # Assign the second parameter to a local variable 'age'
    echo "Hello, $name! You are $age years old."
}