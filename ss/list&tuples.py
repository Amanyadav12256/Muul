# 🧠 1. List kya hoti hai?
#
# 👉 List = multiple values ek jagah store karna
#
# 📌 List mutable hoti hai (change ho sakti hai)

# Example
numbers = [10,20,30,40]
name = ["Aman","Ravinsh","Shivi","Priya"]

#🖨️ List print karna

print(numbers)
print(name)

# 🔍 Indexing in List

print(numbers[0])
print(numbers[2])
print(name[3])

# ✂️ Slicing in List

print(name[0:2])
print(numbers[0:2])

# 🔧 List Functions (Important)
# 🔹 1. append() → value add karna

numbers1 = [20,40,60]
numbers1.append(80)
print(numbers1)

# 🔹 2. insert() → specific position par add
numbers1.insert(2, 30)
print(numbers1)

#
numbers1.remove(20)
numbers1.remove(40)
print(numbers1)

# 4. pop() → last element remove

numbers1.pop()
print(numbers1)

# 🔹 5. sort() → sorting

numbers2 = [80,60,55,23,100,123,321,1,34]
numbers2.sort()
print(numbers2)

# Real Example
marks = [85, 90, 78, 92]

marks.append(88)
marks.sort()

print(marks)

# 🔒 2. Tuple kya hota hai?
#
# 👉 Tuple = list jaisa hota hai, lekin change nahi hota
#
# 📌 Tuple immutable hota hai ❌ (change nahi kar sakte)

numbers3 = [10,23,34,45,56]
print(numbers3)
print(numbers3[0])
print(numbers3[4])

# ⚠️ Difference (List vs Tuple)
# Feature	    List	   Tuple
# Change	   ✅ Yes	   ❌ No
# Syntax	     [ ]	    ( )
# Speed       	Slow	    Fast


# 🎯 Homework
# Ek list banao (5 numbers)
# Ek number add karo
# List ko sort karo
# Ek tuple banao aur uska first element print karo

fnumbers = [10,32,43,54,65]
fnumbers.append(76)
fnumbers.sort()

print(fnumbers)

rrr = [10,20,30]
print(rrr[1])

# Descending sort

fnumbers.sort(reverse=True)
print(fnumbers)


# Tuples

f = (1, 45,342,3434)
print(type(f))

# tuples Method

# count()
#
# 👉 Ye batata hai koi value tuple me kitni baar aayi hai

print(f.count(45))

# 2. index()
#
# 👉 Ye batata hai koi value pehli baar kis position (index) pe aayi hai

t = (10, 20, 30, 20, 40)

print(t.index(20))

# 🔥 Important Notes
# Tuple immutable hota hai → change nahi kar sakte
# Isliye list ki tarah multiple methods nahi hote
# Sirf 2 methods:
# count()
# index()

# 🔹 Bonus Example (Real Use)

marks = (80, 90, 75, 90, 60)

# kitne students ne 90 score kiya
print("90 marks count:", marks.count(90))

# 75 kis position pe hai
print("75 index:", marks.index(75))