
--!strict
-- NOCTELLE | Stack Layout Primitive
-- Phase 1D
-- Vertical layout with shared design tokens.

local Tokens = require(script.Parent.Parent.Foundation.Tokens)

local Stack = {}

local React = require(
    game:GetService("ReplicatedStorage")
        :WaitForChild("NoctelleReactDev")
        :WaitForChild("Packages")
        :WaitForChild("React")
)

local e = React.createElement

export type Props = {
    Spacing: number?,
    HorizontalAlignment: Enum.HorizontalAlignment?,
    VerticalAlignment: Enum.VerticalAlignment?,
}

function Stack.Layout(props: Props?)
    props = props or {}

    return e("UIListLayout", {
        Name = "StackLayout",
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Vertical,

        HorizontalAlignment =
            props.HorizontalAlignment
            or Enum.HorizontalAlignment.Left,

        VerticalAlignment =
            props.VerticalAlignment
            or Enum.VerticalAlignment.Top,

        Padding = UDim.new(
            0,
            props.Spacing or Tokens.Space.MD
        ),
    })
end

return table.freeze(Stack)
