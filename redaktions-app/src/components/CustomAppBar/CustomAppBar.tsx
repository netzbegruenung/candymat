import React from 'react';
import AppBar from '@material-ui/core/AppBar';
import { Toolbar, IconButton, Typography, createStyles, WithStyles } from '@material-ui/core';
import MenuIcon from '@material-ui/icons/Menu';
import AccountCircle from '@material-ui/icons/AccountCircle';
import { withStyles } from '@material-ui/styles';


const styles = createStyles({
  menuButton: {
    marginRight: 16,
  },
  title: {
    flexGrow: 1,
  },
})
interface AppBarProps extends WithStyles<typeof styles> { }

class ProtoCustomAppBar extends React.PureComponent<AppBarProps> {
  public render() {
    return (
      <AppBar>
        <Toolbar>
          <IconButton edge="start" className={this.props.classes.menuButton} color="inherit" aria-label="menu">
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" className={this.props.classes.title}>
            Candymat Redaktion
          </Typography>
          <IconButton edge="start" className={this.props.classes.menuButton} color="inherit" aria-label="user">
            <AccountCircle />
          </IconButton>
        </Toolbar>
      </AppBar>
    );
  }
}

export const CustomAppBar = withStyles(styles)(ProtoCustomAppBar);
