# В директории N содержатся папки «продуктов» разных версий. Название папки продукта
# состоит из латинских букв символа подчеркивания и версии. Формат версии следующий
# «Х.У.*.*» т.е. версия – это числа разделенные точкой. Например, папка с именем
# «Service_3.7.5.100» означает, что внутри находится дистрибутив продукта «Service» версии
# 3.7.5.100. Таким образом, в директории N содержатся папки сервисов разных версий. Например:
# N -|
# Service_3.7.6.10
# Service_3.7.6.100
# Service_3.7.7
# WebService_3.7.5.10
# WebService_3.7.6
# Что сделать:
# Написать универсальный скрипт очистки директории N от папок продуктов версии старше\старее
# заданной. У скрипта два параметра запуска: «директория N» «версия»
# Доп. 3.7.5 старее, чем 3.7.5.10; 3.7.6.100 старее, чем 3.8

#!/bin/bash


function gen_dir() {
    mkdir \
"Service_3.7.7" \
"sErvice_3.7.7" \
"service_3.7.7" \
"Service_3.7.6.10" \
"Service_3.7.6.100" \
"Service_3.7.68.100" \
"Service_3.7.7" \
"WebService_3.7.5.10" \
"WebService_3.7.6" \
"service_3.7" \
"sErvice_3.7" \
"Service_3.7" \
"WebService___3.7.6" \
"WebService___333.7.6" \
"WebService_3.7.5.10a" \
"abc_123.12" \
"123" \
"2abc" \
"abc"
}

# gen_dir

# rm relevant.txt dirs.txt

# PATH_WHERE=$1
# VERSION=$2
# REGEX_DIRNAME="^\.\/[A-Za-z]*[_]{1}[0-9]{1}\.[0-9]{1}\.[0-9]*\.?[0-9]*$"

VERSION_STOP=$1
# FIRST_PART=${VERSION_STOP:0:1}
# SECOND_PART=${VERSION_STOP:2:1}
# NUM_STOP=$FIRST_PART$SECOND_PART

str_of_dots="${VERSION_STOP//[^.]}"
num_of_dots=${#str_of_dots}
echo $num_of_dots


for (( X=0; X < 10; X++ )); do
    for (( Y=0; Y < 10; Y++ )); do
        if [ $num_of_dots -eq 1 ]; then
            if [ "$X$Y" -lt $NUM_STOP ]; then
                echo "$X.$Y"
            fi
        fi

        if [ $num_of_dots -eq 2 ]; then
            for (( Z=0; Z < 100; Z++ )); do
                if [ "$X$Y$Z" -lt $NUM_STOP ]; then
                    echo "$X.$Y.$Z"
                fi
            done
        fi

        if [ $num_of_dots -eq 3 ]; then
#            ...
        fi

    done
done

# if [ $VERSION -eq "0.2" ]; then
#     REGEX_DIRNAME="^\.\/[A-Za-z]*[_]{1}[0]{1}\.[1]{1}\.[0-9]*\.?[0-9]*$"
# fi
# if [ $VERSION -eq "0.3" ]; then
#     REGEX_DIRNAME="^\.\/[A-Za-z]*[_]{1}[0]{1}\.[1]{1}\.[0-9]*\.?[0-9]*$"
# fi









# echo "path is $PATH_WHERE"
# echo "Service_$VERSION"


# cd $PATH_WHERE && find . -type d >> $OLDPWD/dirs.txt
# grep -E $REGEX_DIRNAME dirs.txt >> relevant.txt




# grep -E ^[A-Za-z]$ dirs.txt


















