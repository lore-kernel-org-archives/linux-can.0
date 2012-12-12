From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v3 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Wed, 12 Dec 2012 14:42:26 +0100
Message-ID: <50C889C2.2040305@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com> <loom.20121212T131741-530@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33417 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2LLNm2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Dec 2012 08:42:28 -0500
In-Reply-To: <loom.20121212T131741-530@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Christian Bendele <Christian.Bendele@gmx.net>
Cc: linux-can@vger.kernel.org

On 12/12/2012 01:51 PM, Christian Bendele wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>>
>> Hello,
>>
>> here is v3 of my patches for the C_CAN drivers.
> 
> What are those patches against? They don't apply against current mainstream
> kernel (3.7)... 

They are against David Miller's "net-next" tree, which you can get as
shown below:

git clone --reference=<another-recent-linux-tree> \
	git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next

>> Anyway, we now know that the handling of reveive objects is not water-
>> proof. To fix out-of-order receipten we should implement an improved
>> algorithm as suggested by Marc here:
>>
>>   http://marc.info/?l=linux-can&m=135487418225533&w=2

> 
> I'd like to take a look at this, but unfortunately that link consistently times
> out for me.

Try http://news.gmane.org/gmane.linux.can instead. Search for:

7 Dec 10:55	Marc Kleine-Budde	
***********	[RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can

>> I will not have time to look into that befoer Xmas. Volunteers are
>> welcome.
> 
> Pfffffft.... Personally I wouldn't be opposed to investing some time in this,
> but I don't think I could get this cleared through legal in any useful time 
> frame. 
> Definitely not before next year. If there's still a lot of work left in January
> I'll give it a try.

Hope I will find the time before beginning of next year. Anyway, would
be nice ifyou could give the c_can_pci driver a try to see if it works
better than the pch_can.

Thanks,

Wolfgang,

