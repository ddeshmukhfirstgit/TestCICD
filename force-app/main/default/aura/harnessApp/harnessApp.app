<aura:application >
    <!-- Include the SLDS static resource (adjust to match package version) -->
    <ltng:require styles="/resource/slds/assets/styles/salesforce-lightning-design-system-ltng.css"/>
    
    <!-- Add the "scoping" element to activate SLDS on components
         that we add inside it. -->
    <div class="akshayLightning">
        
        <!-- This component is the real "app" -
        <c:campingList />-->
        <c:JsonGeneratorCmp methodName="getProvisionDetails" sObjectId="" parameterName=""/>
        
    </div>
    <!-- / SLDS SCOPING DIV -->
    
</aura:application>