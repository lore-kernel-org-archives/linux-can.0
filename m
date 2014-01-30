From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/5] can: sja1000: cleanups and new OF property
Date: Thu, 30 Jan 2014 16:27:42 +0100
Message-ID: <52EA6F6E.1010405@epfl.ch>
References: <1391092168-21246-1-git-send-email-florian.vaussard@epfl.ch> <52EA6E31.2030604@pengutronix.de>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:35485 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492AbaA3P1w (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Jan 2014 10:27:52 -0500
In-Reply-To: <52EA6E31.2030604@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 01/30/2014 04:22 PM, Marc Kleine-Budde wrote:
> Hello Florian,
> 
> On 01/30/2014 03:29 PM, Florian Vaussard wrote:
>> The first part of this series performs serveral small cleanups
>> (patches 1 to 3).
> 
> Thanks for your contribution. I like patches 1 and 2.
> 
>> The second part introduces the 'reg-io-width' binding (already used
>> by some other drivers) to perform a similar job as what was done
>> with IORESOURCE_MEM_XXBIT on the sja1000_platform. This is needed
>> on my system to correctly take into account the aliasing of the
>> address bus.
> 
> And I appreciate the improvements for the of_platform driver. However
> that driver was written back when it was not possible to have platform
> and of bindings in the same driver. So I'd like to see that the
> of_platform driver gets merged into the platform driver.
> 

Fine. Is an incremental patch on top of this series ok for you ?

Regards,

Florian
