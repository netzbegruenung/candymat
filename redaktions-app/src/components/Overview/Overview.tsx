import { WithStyles, createStyles, Paper, Typography, Button, withStyles } from "@material-ui/core";
import React from "react";
import { ExistingQuestions } from "components/ExistingQuestions/ExistingQuestions";


const styles = createStyles({
  mainPaper: {
    height: '100%',
    margin: '100px 50px 30px',
    backgroundColor: 'white',
    padding: '50px 30px 30px',
  },
})

interface OverviewProps extends WithStyles<typeof styles> { }


class ProtoOverview extends React.PureComponent<OverviewProps> {
  public render() {
    return (
      <Paper className={this.props.classes.mainPaper}>
        <Typography component="h1" variant="h4" align="center">
          Existierende Fragen
        </Typography>
        <ExistingQuestions />
        <Button variant='contained' color='primary'>
          Neue Frage erstellen
        </Button>
      </Paper>
    )
  }
}

export const Overview = withStyles(styles)(ProtoOverview)
