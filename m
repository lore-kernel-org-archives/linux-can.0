From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939 ACL
Date: Sat, 20 Jan 2018 22:28:09 +0100
Message-ID: <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
 <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:54956 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756652AbeATV2N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 20 Jan 2018 16:28:13 -0500
Content-Disposition: inline
In-Reply-To: <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: =?utf-8?B?UsOpbXk=?= Dziemiaszko <remy.dziemiaszko@smile.fr>, Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org

> Hi
> 
> thank you all!
> 
> after playing with jacd i have a bit more questions:
> - do any one already using kernel j1939? any suggestions or request for
> changes?

A linux 3.10 version runs in production. Since then, a few changes were
requested and implemented.
Recently, the stack had some serious retesting, you will find the
latest state in my github (only a few minor commits from Marc's
version).

> - is jacd used for productions systems? is it enough to have it in the
> usersapce? timing issues?

Equally yes. Timing, as already said, isn't very critical.

> - how address and naming are synced between applications?

The kernel does not decide on claiming addresses, but tracks whatever
happens on the bus.
A node (source or destination) is identified by either a static address
or a 64bit NAME. In case of the static address, there is no need to
sync. In case of using the NAME, only the kernel needs the actual
address, hence the tracking of the bus.
For received packets, the kernel adds the actual address in the struct
sockaddr(_can).
For sent packets, the kernel avoids the need to sync addresses by using
NAME's and filling in the actual address just-in-time, right before the
CAN frame is sent, without the application (who is interested in the
NAME only) needing to know the latest state.

> On 18.01.2018 12:49, Rémy Dziemiaszko wrote:
> > Le 18/01/2018 à 10:40, Oleksij Rempel a écrit :
> >> Hi all,
> > Hi Oleksij,
> >> what is the proper or expected way for j1939 ACL (address claiming)?
> >>
> >> Should it be done by automatically by kernel? Are there any existing
> >> examples?
> > The address claiming is not under the responsibility of the kernel but
> > under responsibility of user space.
> > You should have a look and play with the jacd daemon that implements the
> > Address Claiming procedure for you (see [1]).
> >> Is this a correct ACL message?
> >> source address: for example 0x80
> >> PGN: 0xee00
> >> DATA: NAME
> > Yes that is correct but do not forget to set the destination adresse to
> > "everybody" (0xFF)
> > 

Kurt
