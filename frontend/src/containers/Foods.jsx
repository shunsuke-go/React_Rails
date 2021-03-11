import React, { useEffect, useReducer } from 'react'
import { fetchFoods } from '../apis/foods'
import {
  foodsReducer,
  initialState as foodsInitialState,
  foodsActionTypes,
} from '../reducers/foods'
import { REQUEST_STATE } from '../constants'
import { Fragment } from 'react'

export const Foods = ({ match }) => {
  const [foodsState, dispatch] = useReducer(foodsReducer, foodsInitialState)
  useEffect(() => {
    dispatch({ type: foodsActionTypes.FETCHING })
    fetchFoods(match.params.restaurantsId).then((data) => {
      dispatch({
        type: foodsActionTypes.FETCH_SUCCESS,
        payload: { foods: data.foods },
      })
    })
  }, [])

  return (
    <>
      {foodsState.fetchState === REQUEST_STATE.LOADING ? (
        <>
          <p>ロード中...</p>
        </>
      ) : (
        foodsState.foodsList.map((food) => <div key={food.id}>{food.name}</div>)
      )}
    </>
  )
}
