From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Re: J1939 crash after receiving BAM frame and no DT frame
Date: Wed, 25 Nov 2015 16:16:56 +0100
Message-ID: <CAA7hF3xDeRRg3LXyfzWtY_DxmMUM8bL=sxvRcAEwHr_G4GsZ=A@mail.gmail.com>
References: <loom.20151120T162359-379@post.gmane.org>
	<20151123200923.GA4556@airbook.vandijck-laurijssen.be>
	<CAA7hF3zr0jcJNRn6EYVuFfhg-xCab5MR=B4budC1Pzce0xL7zg@mail.gmail.com>
	<20151125132633.GE764@airbook.vandijck-laurijssen.be>
	<CAA7hF3zSyPFDEzuPWmwwBhTf3005U_g8fEV3ses5_i+Gi=_ecw@mail.gmail.com>
	<5655CCDE.2090701@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33644 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbKYPQ6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 10:16:58 -0500
Received: by lfaz4 with SMTP id z4so64281708lfa.0
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2015 07:16:56 -0800 (PST)
In-Reply-To: <5655CCDE.2090701@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Hi Marc,
the "patch" tried below


On Wed, Nov 25, 2015 at 3:59 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 11/25/2015 02:39 PM, laurent vaudoit wrote:
>>>> i have found a workaround, working with rtpatch, but not sure if this
>>>> can be considered as a bug fix or not.
>>>> in function j1939tp_rxtask, there is a call to j1939session_cancel,
>>>> who call put_session
>>>> and at the end of j1939tp_rxtask, we call put_session.
>>>> if i comment this "second call" to put_session, the problem disappear.
>>>
>>> It seems that you added a memory leak because put_session if a ref
>>> counter. You keep the session installed ... forever, or until a next
>>> similar session is about to be created.
>>>
>>> I'm not sure either that this is the correct way to proceed.
>>
>> i'm not sure i understand well.
>> this seems weird for me to have one get_session and 2 put_session
>> should'nt we have one get_session and one put_session only? (this is
>> what i tried)?
>
> Maybe copy/pasting your patch here make the discussion easier :)

diff --git a/net/can/sj1939/transport.c b/net/can/sj1939/transport.c
index aa395b0..8d79949 100644
--- a/net/can/sj1939/transport.c
+++ b/net/can/sj1939/transport.c
@@ -165,6 +165,7 @@ static void put_session(struct session *session)
        tasklet_disable_nosync(&session->rxtask);
        tasklet_disable_nosync(&session->txtask);

+
        if (in_interrupt()) {
                spin_lock_bh(&s.del.lock);
                list_add_tail(&session->list, &s.del.sessionq);
@@ -511,7 +512,6 @@ static void j1939tp_rxtask(unsigned long val)
        get_session(session);
        pr_alert("%s: timeout on %i\n", __func__, session->cb->ifindex);
        j1939session_cancel(session, ABORT_TIMEOUT);
-       put_session(session);
 }

 /*


>
> Marc
Laurent
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
