From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Thu, 18 Dec 2014 14:45:40 +0100
Message-ID: <5492DA84.4070604@hartkopp.net>
References: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net> <loom.20141218T070747-796@post.gmane.org> <549280D0.6060507@hartkopp.net> <3595849.EjdlQbi96i@heinz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:44593 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbaLRNpn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Dec 2014 08:45:43 -0500
In-Reply-To: <3595849.EjdlQbi96i@heinz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?windows-1252?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org
Cc: Tom Evans <tom_usenet@optusnet.com.au>

On 18.12.2014 11:02, Heinz-J=FCrgen Oertel wrote:
> Am Donnerstag, 18. Dezember 2014, 08:22:56 schrieb Oliver Hartkopp:
>> The candump in can-utils provide this option:
>>
>>          https://gitorious.org/linux-can/can-utils/
>>
>> You may "git clone" the latest version and build it from source.
>>
>
>
> You might need to
> 	sudo apt-get install  autoconf
> 	sudo apt-get install  libtool
>
> or on OpenSUSE
> 	sudo zypper in autoconf
> 	sudo zypper in libtool
>
> to build the tools
>

Yes. That the good way.

The bad way is to say 'make && make install' as root ;-)

Thanks Heinz!

Best regards,
Oliver

