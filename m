From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Restricting permissions to CAN sockets
Date: Wed, 10 May 2017 22:00:25 +0200
Message-ID: <fb34deb2-fb70-4d2b-67c3-bda0d63e2d7d@hartkopp.net>
References: <CAL26GymsvEouJWpLDRi25N9HNDN2D=XfNppZPhFdqv_VWD5UPw@mail.gmail.com>
 <405c0a55-fa2f-8758-132f-4afd7740cf93@hartkopp.net>
 <CAL26Gy=xPku1F65xKfts=8pt4HGVjSySk=X=BiR6oagcqUKMQw@mail.gmail.com>
 <4214b2bc-ea8c-d961-6c04-9f01d7dc930e@hartkopp.net>
 <CAL26Gymp7GOw0s=FfdGsmaBuCP1mEb8sHkgRP5WGRGLHKfOVWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:35612 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdEJUAd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2017 16:00:33 -0400
In-Reply-To: <CAL26Gymp7GOw0s=FfdGsmaBuCP1mEb8sHkgRP5WGRGLHKfOVWQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Doug Zobel <restart334@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Doug,

On 05/09/2017 11:31 PM, Doug Zobel wrote:
> Thanks for the suggestions.
>
> Namespaces look like a simple clean solution, however it may be
> difficult for us to use until it makes it into an LTS kernel.

I don't know about other securing techniques that may fit here too.
E.g. probably selinux or some other stuff granting specific applications 
to use specific syscalls could be interesting ...

Regards,
Oliver

>
> I'll look into adding a system capability check on my current kernel.
>
> -Doug
>
> On Tue, May 9, 2017 at 11:52 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 05/09/2017 04:53 PM, Doug Zobel wrote:
>>>
>>> On Tue, May 9, 2017 at 12:43 AM, Oliver Hartkopp <socketcan@hartkopp.net>
>>> wrote:
>>
>>
>>>>> Perhaps something like iptables but for CAN?
>>>>
>>>>
>>>> Yes. You can use the can-gw module for filtering, routing and modifying
>>>> CAN
>>>> frames.
>>>
>>>
>>> Thanks, I will look into the can-gw module.
>>>
>>>>> I'd like to restrict access to the CAN bus to a single application on
>>>>> the system.
>>>>
>>>>
>>>> 1. don't you trust other applications on the host?
>>>> 2. don't you trust the mentioned single application, so that you would
>>>> need
>>>> some filtering?
>>>>
>>>>
>>>> Whom do you want to restrict?
>>>
>>>
>>> I don't trust other applications (users) on the system.  If a person
>>> were to gain access to the system through an exploit, I'd like to make
>>> sure they can't inject CAN messages.  I'd like to be able to restrict
>>> access to the PF_CAN socket to root or to a single process.
>>
>>
>> I would see two different ideas for your requirement:
>>
>> 1. use network namespaces (which is new in Linux 4.12+)
>> 2. implement capabilities in your modified Linux kernel
>>
>> For the first idea you can move your application into a separate namespace
>> and move the (real) CAN interface there too.
>>
>> http://marc.info/?l=linux-can&m=149330893417415&w=2
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/net/can?id=c2701b370e6b4d0022043691b5ac7adad015e4fc
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a8f820a380a2a06fc4fe1a54159067958f800929
>>
>> For the second idea you might integrate a ns_capable() check when accessing
>> CAN sockets. So this has to be added in raw.c and bcm.c .
>>
>> Try 'git grep -C10 ns_capable' to find examples.
>> (This applies to the latest kernel tree with namespace support)
>>
>> Or you can check for 'git grep -C10 capable' for Linux 4.11 and older.
>>
>> Adding some
>>
>>         if (!capable(CAP_NET_ADMIN))
>>                 return -EPERM;
>>
>> checks at socket functions would restrict the use to admin users.
>>
>> There are even more capabilities than CAP_NET_ADMIN in
>> linux/include/uapi/linux/capability.h
>>
>> So you can check what fits best for your case.
>>
>> Regards,
>> Oliver
>>
