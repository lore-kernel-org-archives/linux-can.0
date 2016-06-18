From: Alexander Aring <aar@pengutronix.de>
Subject: Re: [PATCH v2] can: build proc support only if CONFIG_PROC_FS is
 activated
Date: Sat, 18 Jun 2016 13:19:58 +0200
Message-ID: <a4cd0b07-9dd8-b7db-b45f-dc7dd9e17947@pengutronix.de>
References: <1466165326-29777-1-git-send-email-mkl@pengutronix.de>
 <57650D13.1030706@hartkopp.net>
 <d8067cd1-12c7-56cf-30fc-5e88c2ee6a2e@pengutronix.de>
 <57651749.7070603@hartkopp.net>
 <6dcab1d0-274c-eac9-0c36-eb098823e3c2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55489 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751090AbcFRLUA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jun 2016 07:20:00 -0400
In-Reply-To: <6dcab1d0-274c-eac9-0c36-eb098823e3c2@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

On 06/18/2016 01:15 PM, Alexander Aring wrote:
> 
> Hi,
> 
...
> I think this was some kind of gcc change and I used my host compiler
> which occured this warning in a special gcc version.
> 
> My gcc version is now and it seems they revert the change:
> 
> gcc (GCC) 6.1.1 20160602
> 
> and I don't see such warning anymore when CONFIG_PROC_FS isn't set.
> 

checked my mails again, it was gcc version:

gcc (GCC) 6.1.1 20160501

which produced such warnings.

- Alex
