From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 1/2] Add documentation for SPI to CAN driver
Date: Wed, 29 Oct 2014 21:33:48 +0100
Message-ID: <54514F2C.10108@hartkopp.net>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-2-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:11834 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbaJ2Udz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Oct 2014 16:33:55 -0400
In-Reply-To: <1406565510-10783-2-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Stefano,

sorry that I did not find some time to review your driver again :-(

I found some small issues:

On 28.07.2014 18:38, Stefano Babic wrote:
> Signed-off-by: Stefano Babic <sbabic@denx.de>


> +The CFG_MSG_GET is sent at the start up to query the CAN controller about its
> +internal timing, making them available to the netlink interface. CAN drivers
> +have usually fest values for can_bittiming_const.

fest -> fixed

> In case of a remote
> +CAN controller driven via SPI, the Main Controller cannot know the timing
> +and must ask them to the CAN controller before instantiating a CAN device.
> +For this reason, the message is sent only once in the probe() entry point.
> +
> +The REQ_DATA is sent only by the Main Controller when the Main Controller
> +signals it has packets to be transfered, but the Main Controller has nothing
> +to sent.

?? Didn't understand this - really ;-)


> +8.6 Format of Get Configuration Message
> +----------------------------------------
> +
> +Format of the frame sent by Main Controller:
> +  _____,________
> + |     |        ,'''''''''|'''''''''|
> + |ID=6 | LEN=3  | channel |CHECKSUM |
> + |_____L________|_________|_________|
> +
> +Answer from CAN Controller:
> +  _____,________
> + |     |        ,''''''''''''''''''''|''''''''''|'''''''''|'''''''''|..
> + |ID=6 | LEN=25 | channel |tseg1_min |tseg2_max |tseg2_min|         |CHECKSUM
> + |_____L________|_________|__________|__________|_________|_________..
> +
> +	Offset
> +	0	0x06 (CFG_MSG_GET)
> +	1-2	25
> +	3	channel number
> +		0xFF = CFG
> +		0..n = CAN controller CAN channel
> +	5	tseg1_min
> +	6	tseg1_max
> +	7	tseg2_min
> +	8	tseg2_max
> +	9	sjw_max
> +	10-13	brp_min
> +	14-17	brp_max
> +	18-21	brp_inc
> +	22	ctrlmode

Why is ctrlmode not 32 bit?

> +	23-27	clock
> +	28-29	Checksum

Some more stuff in the other patch.

Regards,
Oliver
