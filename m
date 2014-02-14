From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next] Add CAN FD driver infrastructure
Date: Fri, 14 Feb 2014 21:58:55 +0100
Message-ID: <52FE838F.6030601@hartkopp.net>
References: <52F291D8.90008@hartkopp.net> <52F374DC.3000105@pengutronix.de> <52F3DC33.6080402@hartkopp.net> <52FB57BD.90704@pengutronix.de> <52FBCC8B.3090905@hartkopp.net> <52FCB2AF.1010400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:29792 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbaBNU65 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Feb 2014 15:58:57 -0500
In-Reply-To: <52FCB2AF.1010400@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

My first git send-email is just out now :-)

BR Oliver

On 13.02.2014 12:55, Marc Kleine-Budde wrote:
> On 02/12/2014 08:33 PM, Oliver Hartkopp wrote:
>> On 12.02.2014 12:15, Marc Kleine-Budde wrote:
>>> On 02/06/2014 08:02 PM, Oliver Hartkopp wrote:
>>>> My patch is currently based on Davems net-tree, as this patch
>>>>
>>>> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=0ae89beb283a0db5980d1d4781c7d7be2f2810d6
>>>>
>>>> is currently not in mainline nor in net-next nor in linux-can-next.
>>>>
>>>> As the above patch clashes with the changes I did, I'll wait for Daves
>>>> net-next tree to be opened for development again before sending the patch set.
>>>
>>> net-next is open and I've send a pull request to merge can-next/testing
>>> branch. Do you have a series with split patches I can have a look at?
>>>
>>
>> Not yet. I'll try to prepare them asap.
>> As the current pull request is just out I hope it's ok to prepare them this
>> weekend ?!?
> 
> Sure, but I'm working on the berr_limit feature again, which will extend
> the netlink interface, too.
> 
> Marc
> 
