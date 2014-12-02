From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v4 4/6] can: flexcan: Consolidate and unify state change handling.
Date: Tue, 2 Dec 2014 13:22:43 +0000
Message-ID: <20141202132243.16198.81379@shannon>
References: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net>
 <547B7CDD.2080202@grandegger.com> <20141201110923.29602.38961@shannon>
 <6a5747c2d61b278876b6c3154c6a3130@grandegger.com>
 <20141201115158.1538.64214@shannon>
 <b4ad671712aef49ca40009d6d2ce6d24@grandegger.com>
 <20141201122255.3365.66370@shannon> <547CC491.3070705@grandegger.com>
 <547DB554.8050407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0061.outbound.protection.outlook.com ([157.56.112.61]:59568
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932960AbaLBNYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 08:24:36 -0500
In-Reply-To: <547DB554.8050407@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Quoting Marc Kleine-Budde (2014-12-02 12:49:24)
> On 12/01/2014 08:42 PM, Wolfgang Grandegger wrote:
> [...]
> >> Yes. In any case, the warning interrupt is irrelevant, because we have to poll
> >> the state anyway for the other states. Thus the FLEXCAN_HAS_BROKEN_ERR_STATE
> >> flag is irrelevant.
> > 
> > Well, it improves the situation a little bit. But now I understand your
> > point. Yes the Flexcan core is buggy in this respect.
> 
> Yes, just a bit :) This is probably why they added the m_can core on the
> new imx6 soloX.
>
Interesting! Hopefully they'll make a quadX too. ;)
> 
> >> The question that remains is: Should we enable bus error interrupts for all
> >> flexcan cores or should we ignore the issue and allow the users to work around
> >> it (if they wish) using the berr-reporting flag?
> > 
> > Bus error reporting sometimes really harms and therefore I would leave
> > it as-is. There are also more recent cores and it would be nice to known
> > if they have improved the reporting of state changes further. Anyway,
> > this issue should be addressed by a separate patch series.
> 
> >> There is a middle-ground here: We could enable bus error interrupts when we get
> >> the error-warning interrupt and disable them again when the state has reached
> >> error-active again. In that case we would want to keep the BROKEN_ERR_STATE
> >> flag.
> > 
> > Puh, that's far too sophisticated.
> 
> I agree with Wolfgang. The Bus errors can make a system unresponsive to
> unusable. There is still the bus error limiting patch lurking around,
> which works around this problem.
> 
That's fine by me. It's good enough for me anyway, as is. I might get some
testing done on Saturday. 

--
Andri
