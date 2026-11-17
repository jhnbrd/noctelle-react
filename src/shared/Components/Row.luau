
--!strict
-- NOCTELLE | Row Layout Primitive
-- Phase 1D
-- Horizontal layout with shared design tokens.

local Tokens = require(script.Parent.Parent.Foundation.Tokens)

local Row = {}

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

function Row.Layout(props: Props?)
    props = props or {}

    return e("UIListLayout", {
        Name = "RowLayout",
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,

        HorizontalAlignment =
            props.HorizontalAlignment
            or Enum.HorizontalAlignment.Left,

        VerticalAlignment =
            props.VerticalAlignment
            or Enum.VerticalAlignment.Center,

        Padding = UDim.new(
            0,
            props.Spacing or Tokens.Space.SM
        ),
    })
end

return table.freeze(Row)
