defmodule OpmlTest do
  use ExUnit.Case

  test "parse xml to outline data structure" do
    test_cases = [
      {
        """
        <opml><body>
          <outline text="root" _status="checked" />
        </body></opml>
        """,
        [{"root"}]
      },
      {
        """
        <opml><body>
          <outline text="root1" _status="checked" />
          <outline text="root2" _status="checked"/>
        </body></opml>
        """,
        [{"root1"}, {"root2"}]
      },
      {
        """
        <?xml version="1.0" encoding="UTF-8"?>
        <opml version="2.0">
          <head><!-- <editor>
              <sidebar width="197"/>
              <column name="text" width="762"/>
            </editor> -->
            <title>hsmstack</title>
            <dateCreated>Mon, 14 Dec 2020 07:01:14 GMT</dateCreated>
            <expansionState>1,2,3,5,6,8,9,11,12</expansionState>
            <vertScrollState>0</vertScrollState>
            <windowTop>682</windowTop>
            <windowLeft>352</windowLeft>
            <windowRight>1135</windowRight>
            <windowBottom>1057</windowBottom>
          </head>
          <body>
            <outline text="AWSTemplateFormatVersion: 2010-09-09" _status="checked" />
            <outline text="Resources" _status="checked">
              <outline text="HsmClientEc2Role" _note="Type: AWS::IAM::Role" _status="checked">
                <outline text="Properties" _status="checked">
                  <outline text="RoleName: &quot;MyRole&quot;" _status="checked"/>
                </outline>
              </outline>
              <outline text="HsmClient" _note="Type: AWS::IAM::InstanceProfile" _status="checked">
                <outline text="Properties" _status="checked">
                  <outline text="RoleName: ARole" _status="checked"/>
                </outline>
              </outline>
              <outline text="LaunchTemplate" _note="Type: AWS::EC2::LaunchTemplate" _status="checked">
                <outline text="Properties" _status="checked">
                  <outline text="AmiId: ami-34829347892" _status="checked"/>
                </outline>
              </outline>
              <outline text="AutoScalingGroup" _note="Type: AWS::EC2::AutoScalingGroup" _status="checked">
                <outline text="Properties" _status="checked">
                  <outline text="Min: 3" _status="checked"/>
                </outline>
              </outline>
            </outline>
          </body>
        </opml>
        """,
        [
          {"AWSTemplateFormatVersion: 2010-09-09"},
          {"Resources", [
            {"HsmClientEc2Role", [{"Type: AWS::IAM::Role"}, {"Properties", [{"RoleName: \"MyRole\""}]}]},
            {"HsmClient", [{"Type: AWS::IAM::InstanceProfile"},{"Properties", [{"RoleName: ARole"}]}]},
            {"LaunchTemplate", [{"Type: AWS::EC2::LaunchTemplate"}, {"Properties", [{"AmiId: ami-34829347892"}]}]},
            {"AutoScalingGroup", [{"Type: AWS::EC2::AutoScalingGroup"}, {"Properties", [{"Min: 3"}]}]},
          ]}
        ]
      },
    ]

    for {input, expected} <- test_cases do
      assert Opml.parse(input) == expected
    end
  end

end
