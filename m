From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ offloading
Date: Fri, 4 Sep 2015 13:19:22 +1000
Message-ID: <55E90DBA.2000003@optusnet.com.au>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
 <55E78D42.1060109@optusnet.com.au> <20150903083208.29333e01@archvile>
 <55E7EF8D.306@pengutronix.de> <55E80231.30808@optusnet.com.au>
 <20150903103827.5d08e957@archvile>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:51111 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756392AbbIDDTZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 23:19:25 -0400
In-Reply-To: <20150903103827.5d08e957@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On 03/09/15 18:38, David Jander wrote:
> On Thu, 3 Sep 2015 18:17:53 +1000
> Tom Evans <tom_usenet@optusnet.com.au> wrote:
>
>> On 03/09/15 16:58, Marc Kleine-Budde wrote:
>>> On 09/03/2015 08:32 AM, David Jander wrote:
>>>>>> this series adds a software FIFO implementation and switches
>>
>> Thank you both for explaining that.

And the further explanations and background in the followup email.

Could some of this be added to a documentation file somewhere, or added as a 
paragraph above the QUIRKS table? The existing code definitions and commments 
may be sufficient for people who have been fighting these chips for years, but 
not for someone relatively new to these chips.

>> In an old generation kernel this might be optionally enabled
>
> Why would you want to do that?

For when a new driver is released, and doesn't work for some users.

> It should be known to either work or not for specific hardware (-version),

It should, but sometimes something goes wrong and someone may need to easily 
back out of a new feature to be able to use a new kernel version.

Tom

