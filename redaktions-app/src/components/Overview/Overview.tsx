import { WithStyles, createStyles, Paper, Typography, Button, withStyles } from "@material-ui/core";
import React from "react";
import { ExistingQuestions } from "components/ExistingQuestions/ExistingQuestions";
import { CreateQuestionModal } from "components/CreateQuestionModal/CreateQuestionModal";


const styles = createStyles({
  mainPaper: {
    height: '100%',
    margin: '100px 50px 30px',
    backgroundColor: 'white',
    padding: '50px 30px 30px',
  },
})

interface OverviewProps extends WithStyles<typeof styles> { }

interface OwnState {
  modalOpen: boolean,
}

class ProtoOverview extends React.PureComponent<OverviewProps, OwnState> {
  public constructor(props: OverviewProps) {
    super(props)
    this.state = {
      modalOpen: false,
    }
  }

  public render() {
    return (
      <Paper className={this.props.classes.mainPaper}>
        <Typography component="h1" variant="h4" align="center">
          Existierende Fragen
        </Typography>
        <ExistingQuestions />
        <Button variant='contained' color='primary' onClick={this.createFrage}>
          Neue Frage erstellen
        </Button>
        <CreateQuestionModal open={this.state.modalOpen} handleClose={this.onModalClose}/>
      </Paper>
    )
  };

  private readonly createFrage = () => {
    this.setState({modalOpen: true})
  }

  private readonly onModalClose = () => {
    this.setState({modalOpen: false})
  }
}

export const Overview = withStyles(styles)(ProtoOverview)
