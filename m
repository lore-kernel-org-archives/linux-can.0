From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: [PATCH v3 2/2] Allwinner A10/A20 CAN Controller support
Date: Mon, 07 Sep 2015 18:25:15 +0200
Message-ID: <c0271c81cf9dd9ea16b32375c6dc6449@mail.rdts.de>
References: <1441376988-2384-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441376988-2384-3-git-send-email-info@gerhard-bertelsmann.de>
 <CAJ=nTsuYHPv5OjzowBXy0ss02f7PHKxWV-csxV+u1CZP6dOnYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:35106 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbbIGQZS (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 7 Sep 2015 12:25:18 -0400
In-Reply-To: <CAJ=nTsuYHPv5OjzowBXy0ss02f7PHKxWV-csxV+u1CZP6dOnYQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can-owner@vger.kernel.org

Hi Mirza,

Am 2015-09-05 20:37, schrieb Mirza Krak:
> 
> Might be a good idea to use a prefix for all defines to avoid possible
> conflicts. Something like SUNXI_.
> 
> There have previously been conflicts in the SJA1000 driver, See [1].
> 
> [1]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=06e1d1d71876c75bf4a9d3b310c1b4df34e8be69
> 
> 

thx for your hint. Do you think that's really needed ? The scope of the
defines are limited to this file. There is no other hardware dependant
code involved.

IMHO the SJA1000 is a different story. The SJA1000 could be connected 
via
different busses where other registers are involved.

Nevertheles if the gurus here say I have to change this I'm going to add
a prefix to the defines.


Regards

Gerd
