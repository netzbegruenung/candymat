import { WithStyles, createStyles, withStyles } from "@material-ui/core";
import React from "react";
import { dataApi } from "App";


const styles = createStyles({
  root: {
    padding: '20px 0'
  },
  questionBar: {
    margin: '6px 0',
    padding: 7,
    border: 'solid black 1px',
    width: '100%',
  }
})


interface Question {
  id: number,
  text: string,
  kategorie: string,
}

interface StateProps {
  existingQuestions: Array<Question>,
}

interface ExistingQuestionsProps extends WithStyles<typeof styles> { }


class ProtoExistingQuestions extends React.PureComponent<ExistingQuestionsProps, StateProps> {
  public constructor(props: ExistingQuestionsProps) {
    super(props)
    this.state = {
      existingQuestions: [],
    }
  }

  componentDidMount() {
    fetch(`${dataApi}/fragen/neu`, {method: 'GET'})
      .then(res => res.json())
      .then(json => this.setState({ existingQuestions: json }))
  }

  public render() {
    const questions = this.state.existingQuestions;

    return (
      <div className={this.props.classes.root}>
       {questions.length > 0 ? this.getQuestions() : <span>Es wurden noch keine Fragen erstellt.</span>}
      </div>
    )
  }

  private readonly getQuestions = () => this.state.existingQuestions.map(question => (
  <div key={question.id} className={this.props.classes.questionBar}>
      <span>{question.text}</span>
    </div>
  ))
}

export const ExistingQuestions = withStyles(styles)(ProtoExistingQuestions)
