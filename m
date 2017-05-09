From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Restricting permissions to CAN sockets
Date: Tue, 9 May 2017 18:52:45 +0200
Message-ID: <4214b2bc-ea8c-d961-6c04-9f01d7dc930e@hartkopp.net>
References: <CAL26GymsvEouJWpLDRi25N9HNDN2D=XfNppZPhFdqv_VWD5UPw@mail.gmail.com>
 <405c0a55-fa2f-8758-132f-4afd7740cf93@hartkopp.net>
 <CAL26Gy=xPku1F65xKfts=8pt4HGVjSySk=X=BiR6oagcqUKMQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:12221 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbdEIQwx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 May 2017 12:52:53 -0400
In-Reply-To: <CAL26Gy=xPku1F65xKfts=8pt4HGVjSySk=X=BiR6oagcqUKMQw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Doug Zobel <restart334@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/09/2017 04:53 PM, Doug Zobel wrote:
> On Tue, May 9, 2017 at 12:43 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>>> Perhaps something like iptables but for CAN?
>>
>> Yes. You can use the can-gw module for filtering, routing and modifying CAN
>> frames.
>
> Thanks, I will look into the can-gw module.
>
>>> I'd like to restrict access to the CAN bus to a single application on
>>> the system.
>>
>> 1. don't you trust other applications on the host?
>> 2. don't you trust the mentioned single application, so that you would need
>> some filtering?
>>
>>
>> Whom do you want to restrict?
>
> I don't trust other applications (users) on the system.  If a person
> were to gain access to the system through an exploit, I'd like to make
> sure they can't inject CAN messages.  I'd like to be able to restrict
> access to the PF_CAN socket to root or to a single process.

I would see two different ideas for your requirement:

1. use network namespaces (which is new in Linux 4.12+)
2. implement capabilities in your modified Linux kernel

For the first idea you can move your application into a separate 
namespace and move the (real) CAN interface there too.

http://marc.info/?l=linux-can&m=149330893417415&w=2

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/net/can?id=c2701b370e6b4d0022043691b5ac7adad015e4fc

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a8f820a380a2a06fc4fe1a54159067958f800929

For the second idea you might integrate a ns_capable() check when 
accessing CAN sockets. So this has to be added in raw.c and bcm.c .

Try 'git grep -C10 ns_capable' to find examples.
(This applies to the latest kernel tree with namespace support)

Or you can check for 'git grep -C10 capable' for Linux 4.11 and older.

Adding some

	if (!capable(CAP_NET_ADMIN))
		return -EPERM;

checks at socket functions would restrict the use to admin users.

There are even more capabilities than CAP_NET_ADMIN in
linux/include/uapi/linux/capability.h

So you can check what fits best for your case.

Regards,
Oliver

