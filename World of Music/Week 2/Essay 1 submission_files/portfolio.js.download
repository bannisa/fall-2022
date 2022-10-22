if ( !window.Portfolio )
{
  var Portfolio =
  {};

  Portfolio.AJAX_REQ_CREATING = "creating";
  Portfolio.AJAX_REQ_ONSUCCESS = "onSuccess";
  Portfolio.AJAX_REQ_ONFAILURE = "onFailure";

  Portfolio.saveAsArtifact = function( providerId, sourceData, courseId, userId )
  {
    var url = "/webapps/portfolio/generateRawArtifact?providerId=" + providerId + "&sourceData=" + sourceData +
              "&course_id=" + courseId + "&user_id=" + userId;
    Portfolio.updateButtonLabel( Portfolio.AJAX_REQ_CREATING );
    new Ajax.Request( url,
    {
        method : 'get',
        onSuccess : function( response )
        {
          var jsonObj = Portfolio.parseResponseText( response.responseText );
          if ( jsonObj.artifactId )
          {
            Portfolio.updateButtonLabel( Portfolio.AJAX_REQ_ONSUCCESS );
          }
          else
          {
            Portfolio.updateButtonLabel( Portfolio.AJAX_REQ_ONFAILURE );
          }
        },
        onFailure : function( response )
        {
          Portfolio.updateButtonLabel( Portfolio.AJAX_REQ_ONFAILURE );
        }
    } );
  };

  Portfolio.parseResponseText = function( responseJsonText )
  {
    var jsonObj = JSON.parse( responseJsonText, function( key, value )
    {
      var type;
      if ( value && typeof value === 'object' )
      {
        type = value.type;
        if ( typeof type === 'string' && typeof window[ type ] === 'function' )
        {
          return new ( window[ type ] )( value );
        }
      }
      return value;
    } );
    return jsonObj;
  };

  Portfolio.updateButtonLabel = function( ajaxReqStatus )
  {
    showErrorMsgFnc = function()
    {
      new page.InlineConfirmation( "error", errorMsg, false, true );
    };

    var buttonLabel = page.bundle.getString( "portfolio.saveAsArtifact.button.label.save" );
    var errorMsg = page.bundle.getString( "portfolio.saveAsArtifact.error" );
    var disableButton = false;
    var showErrorMsg = false;

    if ( ajaxReqStatus == Portfolio.AJAX_REQ_CREATING )
    {
      buttonLabel = page.bundle.getString( "portfolio.saveAsArtifact.button.label.saving" );
      disableButton = true;
    }
    else if ( ajaxReqStatus == Portfolio.AJAX_REQ_ONSUCCESS )
    {
      buttonLabel = page.bundle.getString( "portfolio.saveAsArtifact.button.label.saved" );
      disableButton = true;
    }
    else if ( ajaxReqStatus == Portfolio.AJAX_REQ_ONFAILURE )
    {
      buttonLabel = page.bundle.getString( "portfolio.saveAsArtifact.button.label.save" );
      showErrorMsg = true;
    }
    var button = $( 'saveAsArtifactButton' );
    var botButton = $( 'bottom_saveAsArtifactButton' );

    if ( button )
    {
      button.innerText = buttonLabel;
      if ( disableButton )
      {
        button.addClassName( 'disabled' );
      }
      else
      {
        button.removeClassName( 'disabled' );
      }
      if ( showErrorMsg )
      {
        showErrorMsgFnc();
      }
    }
    if ( botButton )
    {
      botButton.value = buttonLabel;
      botButton.disabled = disableButton;
      if ( showErrorMsg )
      {
        showErrorMsgFnc();
      }
    }
  };

  Portfolio.prepareGenericPortfolioMenuEtc = function()
  {
    // TODO: Setup any "common" portfolio-specific client-side behaviour here
    // Now that we are not a 'mybb page' anymore, no need to tell mybb to hide the icons.
  };

  Portfolio.packagePortfolio = function( portfolioId )
  {
    var wait = document.getElementById( 'wait' );
    var inlineReceiptDiv = document.getElementById( 'inlineReceiptDiv' );
    var successMsg = document.getElementById( 'successMsg' );
    var failureMsg = document.getElementById( 'failureMsg' );
    var downloadtxt = document.getElementById( 'downloadtxt' );
    wait.style.display = "block";
    inlineReceiptDiv.style.display = "block";
    successMsg.style.display = "none";
    failureMsg.style.display = "none";
    downloadtxt.style.display = "none";

    var myAjax = new Ajax.Request(
                                   "/webapps/portfolio/execute/portfolio/exportPortfolio?dispatch=export&portfolio_id="+ portfolioId,
                                   {
                                       method : 'get',
                                       onComplete : Portfolio.showComplete,
                                       onSuccess : Portfolio.showSuccess,
                                       onFailure : Portfolio.showFailure,
                                       onException : Portfolio.showException
                                   } );
  };

  Portfolio.showSuccess = function( resultObj )
  {
    var url = resultObj.getResponseHeader( "dlURL" );
    if ( url == "ERROR" )
    {
      Portfolio.abortPackage();
    }
    else
    {
      $( 'dlZipUrl' ).href = url;
      Portfolio.completePackage();
    }

  };

  Portfolio.showComplete = function( resultObj )
  {
  };

  Portfolio.showFailure = function( resultObj )
  {
    Portfolio.abortPackage();
  };

  Portfolio.showException = function( instance, exception )
  {
    Portfolio.abortPackage();
  };

  Portfolio.abortPackage = function()
  {
    var wait = document.getElementById( 'wait' );
    var inlineReceiptDiv = document.getElementById( 'inlineReceiptDiv' );
    var successMsg = document.getElementById( 'successMsg' );
    var failureMsg = document.getElementById( 'failureMsg' );
    var downloadtxt = document.getElementById( 'downloadtxt' );
    wait.style.display = "none";
    successMsg.style.display = "none";
    failureMsg.style.display = "block";
    inlineReceiptDiv.style.display = "block";
    downloadtxt.style.display = "none";
  };

  Portfolio.completePackage = function()
  {
    var wait = document.getElementById( 'wait' );
    var inlineReceiptDiv = document.getElementById( 'inlineReceiptDiv' );
    var successMsg = document.getElementById( 'successMsg' );
    var failureMsg = document.getElementById( 'failureMsg' );
    var downloadtxt = document.getElementById( 'downloadtxt' );
    wait.style.display = "none";
    successMsg.style.display = "block";
    failureMsg.style.display = "none";
    inlineReceiptDiv.style.display = "block";
    downloadtxt.style.display = "block";
  };

}
