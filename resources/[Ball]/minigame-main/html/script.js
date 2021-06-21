$(() => {

    $('body').hide();

    window.addEventListener('message', e => {

        if (e.data.action == 'show') {

            let goals = [];
            const limit = 2.5;
            let hasGameFinished = false;

            const GetPinDistanceToGoal = (element, goal) => {
                return (Math.abs((element.position().left / 3.6) - goal) / 100 * 255).toFixed(2);
            }

            const GenerateGoals = () => {
                $('.pin').map((index, value) => {
                    let valueId = $(value)[0].id;
                    const randomGoal = Number((Math.random() * 100).toFixed(2));
                    goals.push({ id: valueId, value: randomGoal, isRight: false });
                })
            }

            const GetAssignedGoal = (id, callback) => {
                goals.map((value, index) => {
                    if (value.id == id) {
                        callback(value.value);
                    }
                })
            }

            const FinishGame = () => {
                if (!hasGameFinished) {
                    hasGameFinished = true;
                    $.post(`https://minigame/minigameFinished`, JSON.stringify({
                        isSuccess: true
                    }));
                    $('body').hide();
                }
            }

            const CheckIfAllFinished = () => {
                const areAllFinished = goals.every((value, index) => value.isRight);
                if (areAllFinished) {
                    FinishGame();
                }
            }

            const ChangeIsRightValue = (id, isRight) => {
                goals.map((value, index) => {
                    if (value.id == id && isRight) {
                        value.isRight = true;
                        CheckIfAllFinished();
                    }
                })
            }

            $('.pin').draggable({
                axis: 'x',
                containment: '.mainContainer',
                drag: (event, ui) => {
                    const element = $(event.target);
                    const id = element[0].id;
                    GetAssignedGoal(id, goalValue => {
                        const distanceToGoal = GetPinDistanceToGoal(element, goalValue);
                        var mColor = distanceToGoal / 2;
                        if (mColor > 150) { mColor = 150 };
                        element.css('backgroundColor', `rgb(${255 - mColor}, ${255 - mColor}, ${255 - mColor})`);
                        ChangeIsRightValue(id, distanceToGoal < limit ? true : false);
                    });
                }
            });

            const Setup = () => {
                GenerateGoals();
                $('body').show();
                $('.pin').map((index, value) => {
                    const element = $(value);
                    const id = element[0].id;
                    element.css('left', '0px');
                    goals.map((value, index) => {
                        if (value.id == id) {
                            GetAssignedGoal(id, goalValue => {
                                const distanceToGoal = GetPinDistanceToGoal(element, goalValue);
                                var mColor = distanceToGoal / 2;
                                if (mColor > 150) { mColor = 150 };
                                element.css('backgroundColor', `rgb(${255 - mColor}, ${255 - mColor}, ${255 - mColor})`);
                            })
                        }
                    })
                })
            }
            Setup();
        } else if (e.data.action == 'hide') {
            $('body').hide();
        }

        $('body').keydown(e => {
            if (e.which == 8 || e.which == 27) {
                $.post('https://minigame/close', JSON.stringify({}));
                $('body').hide();
            }
        })

    })
})
