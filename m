From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Expose filtered CAN interface to processes
Date: Sat, 30 Jan 2016 11:24:33 +0100
Message-ID: <56AC8F61.5050404@hartkopp.net>
References: <EB7F4954055D8D47BE2774BFC0597392301E1285@MTK-SMS-XCH02.digi.com>
 <56ABC5EE.8070100@hartkopp.net>
 <EB7F4954055D8D47BE2774BFC0597392301E144B@MTK-SMS-XCH02.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:63147 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbcA3KYj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 30 Jan 2016 05:24:39 -0500
In-Reply-To: <EB7F4954055D8D47BE2774BFC0597392301E144B@MTK-SMS-XCH02.digi.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Osborne, Paul" <Paul.Osborne@digi.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andri Yngvason <andri.yngvason@marel.com>

Hello Paul,

On 01/29/2016 10:53 PM, Osborne, Paul wrote:

>>> I am new to network namespaces; Am I missing something?  Is this a
>>> real use case for network namespace support?  It sounded like there
>>> was uncertainty on this point with the RFC that was posted back in
>>> September by Andri: http://comments.gmane.org/gmane.linux.can/8589.
>>
>> Yes. I think this would be the right way to go.
>>
>> My current idea regarding namespace aware virtual CAN interfaces is to create
>> virtual CAN interfaces inside a network namespace. These 'vcan with namespace'
>> interfaces could then be connected via cangw in the initial (real world)
>> namespace to other can/vcan interfaces (with/without namespace) with cangw rules.
>>
>> The good thing about this approach is that you can use the filter and
>> modification capabilities from cangw at the same time.
> 
> Alright, good to know I am not barking up the wrong tree.  As I am
> needing this functionality in the not-too-distant future, I may take a
> shot at putting something together based on the work Andri has done
> and your comments.

Cool!

> I am also putting together a change to allow for filtering on the data
> of CAN messages (in combination with the can_id/mask).  I'm a bit more
> skeptical of that change but may submit an RFC for that as well if the
> changes end up not being too unpalatable.

Oh - I proposed this idea of using the cangw with a namespace aware
configuration as I did not see the standard way creating vcan peers with

	ip link add vcan0 type vcan peer name vcan1

	ip link set vcan0 netns mynamespace

won't work that way. If you have a 'standard' solution I would be happy to see it.

Using the cangw with filtering would help to have some kind of CAN ID firewall
directly - but this might be done in the global namespace too when connecting
the peered vcan1 to some real can0 ...

You can hopefully follow my thoughts as namespaces are new to me too :-)

Best regards,
Oliver
