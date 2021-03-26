function ConvertTo-PSCustomObject {
    [CmdletBinding()]
    [OutputType('PSCustomObject')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    begin {
        $newobject = New-Object Object
    }
    process {
        foreach ($object in $InputObject) {
            $object.GetEnumerator() | ForEach-Object {
                Add-Member -InputObject $newobject -MemberType NoteProperty -Name $_.Name -Value $_.Value
            }
        }
    }
    end {
        $newobject
    }
}