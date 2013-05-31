From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: RFC: (optional) software filtering in candump
Date: Fri, 31 May 2013 22:40:21 +0200
Message-ID: <51A90AB5.5010708@sebastianhaas.info>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info> <51A77657.5060004@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:36623 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab3EaUkW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 May 2013 16:40:22 -0400
In-Reply-To: <51A77657.5060004@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

>> I still dont understand why I receive the same CAN message twice just because
>> the filter matched? Can someone explain the logic behind that?
>>
>
> You added two independent filters, both matching 0x1FF.
>
> When you invoke this:
>
> candump vcan0,100~7ff,101~7ff,000:000
>
> you will get the CAN frame with the CAN ID 1FF three times.
>
> Clearly now?
I understoot how the filter system is working, but don't why it was 
implemented this way.

What is the use case for an application to receive messages twice or 
more just because more filters matched? I cannot imagine any reason to 
process more frames than the node actually receive.

Cheers,
Sebastian
