## Kubernetes Imperative & Declarative Approach

### YAML Basics
-   YAML is used to store information about different things. We can use YAML to `define Key, Value Pair` like variables, lists and objects
-   YAML is similar to JSON. YAML primarily focuses on `readability` and user `friendliness`.
-   YAML is designed to be `clean and easy to read`.
-   We can define YAML files with two different extensions like `.yaml and .yml`.

    **keytopics**
    -   YAML Comments
    -   YAML Key Value Pairs
    -   YAML Dictionary and Map
    -   YAML Arrays and List
    -   YAML Spaces
    -   YAML Document Seperator

### Comments and KeyValue Pairs
-   space on colon is mandatory to differentiate key and vlaue.
```yaml
# simple key value pair (comments)
name: vishnu
age: 34
city: Atlanta
```

### Dictionary / Map
-   Set of properties `grouped together after an item`.
-   Equal amount of blank spaces required for all the items under a dictionary.

```yaml
person: # Dictionary
  name: vishnu
  age: 34
  city: hyderabad
```

### Array/List
-   Dash indicates an element of an array.
```yaml
person: # Dictionary
  name: vishnu
  age: 34
  city: Hyderabad
  hobbies: # List
    - cricket
    - cooking
  hobbies: [cricket, cooking] # List with a different notations
```

### Multiple Lists
```yaml
person: # Dictionary
  name: vishnu
  age: 34
  city: Hyderabad
  hobbies: # List
    - cricket
    - cooking
  hobbies: [cricket, cooking] # List with a different notations
  friends:  # mulitple lists
    - name: naresh
      age: 34
    - name: bhaskar
      age: 34
```

###  sample pod defination

```yaml
person: # Dictionary
  name: vishnu
  age: 34
  city: Hyderabad
  hobbies: # List
    - cricket
    - cooking
  hobbies: [cricket, cooking] # List with a different notations
  --- # Document separator
  apiVersion: v1 # string
  kind: Pod # string
  metadata: # Dictionary
    name: nginx-pod 
    labels: #Dictionary
      app: nginx
  spec: 
    containers: # List
      - name: nginx-container
        image: nginx:1.27.0
        ports: # List
          - containerPort: 80
            protocol: "TCP"
          - containerPort: 81
            protocol: "TCP"
```