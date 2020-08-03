version 1.0

task work {

    command <<<
        memory=$(free -g | head -n 2 | tail -n 1|awk '{print $2}')
        if [ $memory -gt 8 ]; then
            echo $memory
            exit 2
        else
            echo $memory
        fi
    >>>

    runtime {
        docker: "public/ubuntu:18.04"
        memory: "1GB"
        disk: "10GB"
        cpu:1
    }

    output {
        String value = read_string(stdout())
    }

}

workflow sample {
    call work 

    output {
        String value = work.value
    }
}
