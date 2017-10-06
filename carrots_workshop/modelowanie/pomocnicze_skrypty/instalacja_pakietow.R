zainstaluj_pakiety <- function() {
    
    packages <- c("devtools",
                  "ggplot2",
                  "dplyr",
                  "reshape2",
                  "broom",
                  "caret",
                  "xgboost",
                  "randomForest",
                  "randomForestExplainer",
                  "faraway",
                  "rpart",
                  "MASS",
                  "DBI",
                  "sparklyr")
    
    install.packages(packages)
    
    cnt <- 0
    for (pkg in packages) {
        tryCatch({
            library(pkg, character.only = TRUE)
            cnt <- cnt + 1
        },
        error = function(e) {
            cat(sprintf("Brak pakietu '%s'. Spróbuj wykonać komendę
                        install.packages('%s')
                        w konsoli,
                        a następnie
                        library(%s).\n", pkg, pkg, pkg))
        })
    }
    
    if (cnt == length(packages)) {
        cat("Super! Wszystko jest zainstalowane. Do zobaczenia na warsztatach :)")
    } else {
        cat("Czegoś brakuje. Zobacz w logach powyżej, czy któregoś z pakietów nie brakuje i spróbuj zainstalować go jeszcze raz.")
    }
}

zainstaluj_sparka <- function() {
    tryCatch({
        sparklyr::spark_install(version = "2.2.0")
        conn <- sparklyr::spark_connect(master = "local")
        sparklyr::spark_disconnect(conn)
    },  error = function(e) {
        cat("Nie udało się zainstalować Sparka. Wykonaj poniższe polecenia:
            1. Sprawdź, czy masz zainstalowaną Javę (instrukcja do instalacji znajduje się w mailu).
            2. Ustaw ścieżkę środowiskową Javy: 
                Sys.setenv(JAVA_HOME = '<TWOJA ŚCIEŻKA DO JAVY>')\n")
    })
}

zainstaluj_pakiety()
zainstaluj_sparka()
