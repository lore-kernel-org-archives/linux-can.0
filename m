From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC 0/6] pch_can/c_can: fix races and add PCH support to c_can
Date: Mon, 26 Nov 2012 09:50:08 +0100
Message-ID: <50B32D40.1040507@grandegger.com>
References: <1353918186-4234-1-git-send-email-wg@grandegger.com> <50B32CAC.4050501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37231 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2KZIuS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:50:18 -0500
In-Reply-To: <50B32CAC.4050501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 11/26/2012 09:47 AM, Marc Kleine-Budde wrote:
> On 11/26/2012 09:23 AM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> as you might have already realized, Michael has reported problems with
>> the PCH_CAN driver. With his help we try to fix these issues and add
>> PCH PCI support to the C_CAN driver replacing the PCH_CAN driver sooner
>> than later. Here follows my current patch stack for the records. When
>> Michael's tests are successful, I'm going to post final patches.
>>
>> For Michael I have prepared out-of-tree driver sources allowing to
>> easily build the drivers also for older 3.x kernel versions. More
>> tester are welcome.
>>
>> As also pointed out by Casper, the problems are obvisouly due to races
>> with stop and wakeup of the netif tx queue, managing tx_next and
>> concurrent register accesses. For the moment I have fixed the races by
>> adding "spin[un]lock_irqsave/restore" but, thinking more about it,
>> "spinlock_bh" should be enough to protect against softirq context.
>>
>> With the C_CAN driver I realized some other minor issues:
>>
>> - The C/D_CAN type handling is common code and could go to
>>   alloc_c_can_dev() or register_c_can_dev().
>>
>> Comments are welcome.
> 
> Please make the patches based on linux-can-next/for-davem

OK, will do for the next round. For the moment these are just RFC patches.

Wolfgang.

