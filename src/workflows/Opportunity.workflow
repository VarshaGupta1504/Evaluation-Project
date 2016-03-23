<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval_For_Deal</fullName>
        <ccEmails>varshagupta04@yahoo.in</ccEmails>
        <description>Approval For Deal</description>
        <protected>false</protected>
        <recipients>
            <recipient>varshagupta04@yahoo.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_template</template>
    </alerts>
    <alerts>
        <fullName>Big_Deal_Created</fullName>
        <ccEmails>varshagupta04@yahoo.in</ccEmails>
        <description>Big Deal Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_template</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Stage</fullName>
        <description>Opportunity Stage Is Closed Won and Closed Partial</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opp_Touchpoint_1</template>
    </alerts>
    <alerts>
        <fullName>Send_an_email_to_related_contact</fullName>
        <description>Send an email to related contact</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opp_Touchpoint_1</template>
    </alerts>
    <alerts>
        <fullName>Send_an_email_to_related_contact_after_24_hours</fullName>
        <description>Send an email to related contact after 24 hours</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opp_Touchpoint_1</template>
    </alerts>
    <alerts>
        <fullName>Sending_an_email_to_related_contact_to_inform_about_opportunity_stage</fullName>
        <description>Sending an email to related contact to inform about opportunity stage</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opp_Touchpoint_1</template>
    </alerts>
    <alerts>
        <fullName>Sending_email_to_related_contact_to_inform_about_opportunity_stage</fullName>
        <description>Sending an email to related contact to inform about opportunity stage</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opp_Touchpoint_1</template>
    </alerts>
    <alerts>
        <fullName>send_email</fullName>
        <description>send email after 1 day</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opp_Touchpoint_1</template>
    </alerts>
    <rules>
        <fullName>Big Deal Alert</fullName>
        <actions>
            <name>Big_Deal_Created</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Negotiation/Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>greaterThan</operation>
            <value>50000</value>
        </criteriaItems>
        <description>Big deal is being created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Contact</fullName>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Partial</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send an email to related Contact after 1 day</fullName>
        <actions>
            <name>Sending_email_to_related_contact_to_inform_about_opportunity_stage</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send an email to related Contact</description>
        <formula>IF((ISPICKVAL(StageName,&apos;Closed Won&apos;)||ISPICKVAL(StageName, &apos;Closed Partial&apos;))&amp;&amp; Contact__r.Primary_Contact__c &amp;&amp; LastModifiedDate+0.0000578704 &gt;= NOW()==true,true,false)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>send_email</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Touch_Point_2</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Opportunity.CreatedDate</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send an email to related contact</fullName>
        <actions>
            <name>Opportunity_Stage</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Partial</value>
        </criteriaItems>
        <description>Send an to related contact with the “primary contact” check box checked.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Touch_Point_2</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>60</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Touch Point 2</subject>
    </tasks>
</Workflow>
