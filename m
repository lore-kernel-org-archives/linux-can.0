From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/6] CAN FD support
Date: Mon, 18 Jun 2012 21:30:11 +0200
Message-ID: <4FDF81C3.9050108@hartkopp.net>
References: <4FDF67B2.1090004@hartkopp.net> <4FDF7D0E.1000802@pengutronix.de> <4FDF7E10.9050301@hartkopp.net> <4FDF8122.8050608@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:9291 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab2FRTaL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:30:11 -0400
In-Reply-To: <4FDF8122.8050608@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.06.2012 21:27, Marc Kleine-Budde wrote:

> On 06/18/2012 09:14 PM, Oliver Hartkopp wrote:
>>>> You can also pull the series ;-)
>>>
>>> I can pull, but David want's to have a clean tree. So I have to pull and
>>> rebase it on my tree.
>>
>>
>> I created a branch 'canfd' on a clone of *your* can-next.
> 
> No need for that. git pull --rebase works.
>>
>> What's not clean there?
>>
>> You can pull Daves net-next and then pull the canfd branch, right?
> 
> Yes, but David wants to have a clean linear series of patches, not with
> merges in it.


What can i do now to support this?

> 
>>>> Git is hard for newbies but i gave my very best ...
>>>
>>> Once you can use it, you don't want to code without it.
> 
>> Yes -  it's getting better. Indeed it looks like Thunderbird mangles the mails
>> when editing the draft mails.
> 
> Don't do that :)


Yep. Just learned that %-[
