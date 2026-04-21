NAME		:=	minishell

CC			:=	cc
CFLAGS		:=	-Wall -Wextra -Werror -O2
CPPFLAGS	:=	-Iinclude -Ilibraries/libft/inc

# Include parsing table definition
include build/parsing_table.mk
CPPFLAGS	+=	-D PARSING_TABLE=$(PARSING_TABLE)
LDFLAGS		:=	-Llibraries/libft
LDLIBS		:=	-lreadline

SRC_DIR		:=	source
OBJ_DIR		:=	obj

SRCS		:=	$(shell find $(SRC_DIR) -name '*.c')
OBJS		:=	$(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

LIBFT		:=	libraries/libft/libft.a

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(LIBFT) $(OBJS)
	$(CC) $(OBJS) $(LIBFT) $(LDLIBS) -o $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(LIBFT):
	$(MAKE) -C libraries/libft fclean
	$(MAKE) -C libraries/libft

clean:
	rm -rf $(OBJ_DIR)
	$(MAKE) -C libraries/libft clean

fclean: clean
	rm -f $(NAME)
	$(MAKE) -C libraries/libft fclean

re: fclean all
