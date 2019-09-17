import React from 'react';
import { createStyles, WithStyles } from '@material-ui/core/styles';
import Modal from '@material-ui/core/Modal';
import { TextField, Button } from '@material-ui/core';
import { withStyles } from '@material-ui/styles';
import { dataApi } from 'App';


const styles = createStyles({
  paper: {
    margin: 'auto',
    width: 400,
    backgroundColor: 'white',
    border: '2px solid #000',
    padding: 8,
  },
  textField: {
    width: '100%',
  },
  buttonBar: {
    display: 'flex',
    flexDirection: 'row',
  },
  button: {
    margin: 2,
  },
})

interface OwnState {
  frageText: string,
  kategorieText: string,
}

interface OwnProps {
  open?: boolean,
  handleClose(): void,
}

interface CreateQuestionModalProps extends OwnProps, WithStyles<typeof styles> { }

class ProtoCreateQuestionModal extends React.PureComponent<CreateQuestionModalProps, OwnState> {
  public constructor(props: CreateQuestionModalProps) {
    super(props)

    this.state = {
      frageText: '',
      kategorieText: '',
    }
  }
  public render() {
    return (
      <Modal
        aria-labelledby="simple-modal-title"
        aria-describedby="simple-modal-description"
        open={this.props.open ? true : false}
        onClose={this.props.handleClose}
      >
        <div className={this.props.classes.paper}>
          <h2 id="simple-modal-title">Neue Frage erstellen</h2>
          <TextField
            id="frage-text"
            label="Frage"
            multiline
            rows="4"
            className={this.props.classes.textField}
            margin="normal"
            variant="outlined"
            value={this.state.frageText}
            onChange={(e) => this.setState({ frageText: e.target.value })}
          />
          <TextField
            id="kategorie-name"
            label="Kategorie"
            className={this.props.classes.textField}
            margin="normal"
            variant="outlined"
            value={this.state.kategorieText}
            onChange={(e) => this.setState({ kategorieText: e.target.value })}
          />
          <div className={this.props.classes.buttonBar}>
            <Button
              className={this.props.classes.button}
              variant='contained'
              color='primary'
              onClick={this.createFrage}
            >
              Erstellen
            </Button>
            <Button
              className={this.props.classes.button}
              variant='contained'
              color='primary'
              onClick={this.props.handleClose}
            >
              Abbrechen
            </Button>
          </div>
        </div>
      </Modal>
    );
  };

  private readonly createFrage = () => {
    fetch(`${dataApi}/fragen`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({}),
    })
      .then(res => {
        if (res.status === 200) {
          this.props.handleClose();
          alert("Frage wurde erfolgreich erstellt");
        } else {
          alert(`Es ist etwas schief gelaufen. Response: ${res.text}`);
        }
      })
      .catch(err => alert(`Es ist etwas schief gelaufen. Fehler: ${err}`))
  };
}

export const CreateQuestionModal = withStyles(styles)(ProtoCreateQuestionModal)
