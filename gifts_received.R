total_gifts <- function(n) {
    (n^3 + 3*n^2 + 2*n)/6
}

gifts_received_table <- data.frame(day = 1:12)
gifts_received_table$"gifts" <- total_gifts(gifts_received_table$"day")

gifts_received_table |>
    knitr::kable(format = "markdown")

gifts_received_table |>
    knitr::kable(format = "latex")
