From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: No response from candump
Date: Wed, 13 Apr 2016 18:48:15 +0200
Message-ID: <570E784F.10909@hartkopp.net>
References: <AAA1503F-C574-46B9-A465-9F423DCFA872@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:35546 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbcDMQs0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Apr 2016 12:48:26 -0400
In-Reply-To: <AAA1503F-C574-46B9-A465-9F423DCFA872@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kay Cee <unee0x@gmail.com>, linux-can@vger.kernel.org

What does

	ip -details link show can0

say?

On 04/13/2016 12:30 PM, kay Cee wrote:
> I need help getting can signals to show with candump. As of now, when I run candump can0, I get a blank.
>
> My current setup is a Beaglebone Black and a SN65HVD230 transceiver connected to pins 24 and 26 , for can rx and tx respectively.
>
> Please, point me in the right direction to get my setup running correctly.
>
>
>
> Sent from my iPhone--
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
