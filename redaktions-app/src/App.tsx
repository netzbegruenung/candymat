import React from 'react';
import './App.css';
import { createStyles, WithStyles } from '@material-ui/core';
import { withStyles } from '@material-ui/styles';
import { CustomAppBar } from 'components/CustomAppBar/CustomAppBar';
import { Overview } from 'components/Overview/Overview';


export const dataApi = 'http://localhost:5000/graphql'


const styles = createStyles({
  root: {
    flexGrow: 1,
  },
  content: {
    flexGrow: 1,
    height: '100vh',
    maxWidth: 1000,
    marginLeft: 'auto',
    marginRight: 'auto',
  },
})
interface AppProps extends WithStyles<typeof styles> { }

class ProtoApp extends React.PureComponent<AppProps> {
  public render() {
    return (
      <div className={this.props.classes.root}>
        <CustomAppBar />
        <main className={this.props.classes.content}>
          <Overview />
        </main>
      </div>
    );
  }
}

export const App = withStyles(styles)(ProtoApp);
