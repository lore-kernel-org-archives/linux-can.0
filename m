From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mcp25xxfd: missing cerrif
Date: Fri, 14 Feb 2020 14:59:41 +0100
Message-ID: <a049ea8b-a3e2-ea39-d084-bd12b637cb9c@pengutronix.de>
References: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
 <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
 <532b4fed-a984-0875-d933-43c6a90fcc1a@pengutronix.de>
 <MN2PR11MB36458E1696285A0196B6E46FFB1B0@MN2PR11MB3645.namprd11.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgBNN7p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Feb 2020 08:59:45 -0500
In-Reply-To: <MN2PR11MB36458E1696285A0196B6E46FFB1B0@MN2PR11MB3645.namprd11.prod.outlook.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas.Kopp@microchip.com, linux-can@vger.kernel.org

On 2/12/20 10:59 AM, Thomas.Kopp@microchip.com wrote:
>> On the transition from "TX ERROR_WARNING -> TX ERROR_ACTIVE" the 
>> CERRIF is not set.
> Mhm, do I misunderstand your point here?

I misread the documentation somehow.

Hmmm. I think the question is, is there a dedicated warning state and
if, how are the transitions from and to it?

From my understanding:

           -- E > 95 --     -- E > 127 --     -- E > 255 --
          /            \   /             \   /             \
         /              V /               V /               V
--> error active  error warning      error passive       bus off
         ^              / ^               /
          \            /   \             /
           -- E < 96 --     -- E < 128 --

> The Transition TX ERROR_WARNING -> TX ERROR_ACTIVE isn't covered by
> the CERRIF interrupt (which matches the documentation).

ACK. The documentation talks about error passive to error active, which
means the diagram looks like this:

           -- E > 95 --     -- E > 127 --     -- E > 255 --
          /            \   /             \   /             \
         /              V /               V /               V
--> error active  error warning      error passive       bus off
         ^                                /
          \                              /
           ------------------- E < 128 --

> The interrupt bit gets set on ERROR_Passive to ERROR_ACTIVE (TEC/REC
> goes from 128 to 127).

I think we have to discuss how the state diagram on socketcan should
look like.

> At that transition I do see the CERRIF bit. It is correct and
> intended (though maybe not 100% intuitive) that going from
> ERROR_WARNING to ERROR_ACTIVE TEC/REC 96 to 95 CERRIF is NOT being
> set.

Ok.

regards
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
