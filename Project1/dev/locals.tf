locals{
    common_tags = {
        Project = "Akademia DevOps"
        Env = "stage"
        Owner = "Łukasz Byrka"
    }
    app_name = "app-${var.env}"
}