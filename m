From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH 2/4] Consolidate and unify state change handling
Date: Sun, 21 Sep 2014 17:27:28 +0000
Message-ID: <541F0A80.7060800@marel.com>
References: <541B0792.5030002@marel.com> <541C9BD8.8070303@grandegger.com>
 <541EE4E9.9010506@marel.com> <541EEF28.5000103@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0058.outbound.protection.outlook.com ([157.56.110.58]:30388
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751310AbaIUR1c (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 21 Sep 2014 13:27:32 -0400
In-Reply-To: <541EEF28.5000103@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


On sun 21.sep 2014 15:30, Wolfgang Grandegger wrote:
> On 09/21/2014 04:47 PM, Andri Yngvason wrote:
>> On f=C3=B6s 19.sep 2014 21:10, Wolfgang Grandegger wrote:
>>> On 09/18/2014 06:25 PM, Andri Yngvason wrote:
>>>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>>>> ---
>>>> ...
>>>> -            cf->can_id |=3D CAN_ERR_CRTL;
>>>> -            cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>>>> -                CAN_ERR_CRTL_TX_WARNING :
>>>> -                CAN_ERR_CRTL_RX_WARNING;
>>> Hm, can_change_state() handles the equal case differently. In the
>>> SJA1000 manual I found:
>>>
>>> "Errors detected during reception or transmission will affect the e=
rror
>>> counters according to the CAN 2.0B protocol
>>> specification. The error status bit is set when at least one of the
>>> error counters has reached or exceeded the CPU
>>> warning limit of 96. An error interrupt is generated, if enabled."
>>>
>>> If both are equal we do not known if rx or tx has caused the state
>>> change and therefore setting "CAN_ERR_CRTL_TX_WARNING |
>>> CAN_ERR_CRTL_RX_WARNING" seems more logical, indeed. But maybe it s=
imply
>>> does not happen. Any other opinions?
>> I think that not specifically handling the equal case would be wrong=
=2E Let's
>> consider the following sequence of events:
>>   * txerr reaches warning level
>>   * rxerr reaches warning level
>> If they are both equal at this point, you will only get a second
>> CAN_ERR_CRTL_TX_WARNING in the current implementation, whereas in th=
e
>> proposed
>> implementation, the user would get
>> CAN_ERR_CRTL_TX_WARNING | CAN_ERR_CRTL_RX_WARNING and because the us=
er
>> can know
>> the prior error state message, he can find out which state actually
>> changed.
> The question is what error (rx or tx) error did triger the error stat=
e
> change interrupt. I doubt that such an interrupt is triggered when on=
e
> error counter catches up, .e.g. txer was > 128 and rxerr exceeded 128=
=2E
> It's even not sure that all the controllers act the same way. Therefo=
re
> also keeping the current behaviour would be fine for me.
Also, because of the state !=3D priv->state assert, the equal case won'=
t=20
happen
when the state increases, but it might happen when it goes down. Perhap=
s
that should be changed?

But in the case where the state goes down, there will definitely be an
interrupt generated. E.g. rx_state =3D warn, tx_state =3D passive and t=
hen when
tx_state -> warn, we will have the controller's state go to warn from=20
passive,
and then rx_state =3D=3D tx_state. So, if we only want to send which st=
ate
changed, we actually have to keep copies of each counter's current (las=
t)
state, as is done in priv->state, for the whole controller.

I think it would be easier, simpler and more useful to just send the=20
current,
state of each counter whenever the state changes. Consider this:
diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 02492d2..6199571 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -273,6 +273,118 @@ static int can_get_bittiming(struct net_device=20
*dev, struct can_bittiming *bt,
      return err;
  }

+static void can_update_error_counters(enum can_state new_state)
+{
+    if (state < priv->state)
+        return;
+
+    switch (new_state) {
+    case CAN_STATE_ERROR_ACTIVE:
+        netdev_warn(dev, "%s: oops, did we come from a state less than=
=20
error-active?",
+                __func__);
+        break;
=2E..
+}
+
+static int can_txstate_to_frame(enum can_state state)
+{
+    switch(state)
+    {
+    case CAN_STATE_ERROR_ACTIVE:
+        return CAN_ERR_CRTL_TX_ACTIVE;
=2E..
+}
+
+static int can_rxstate_to_frame(enum can_state state)
+{
+    switch(state)
+    {
+    case CAN_STATE_ERROR_ACTIVE:
+        return CAN_ERR_CRTL_RX_ACTIVE;
=2E..
+}
+
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+              enum can_state new_state, enum can_state tx_state,
+              enum can_state rx_state)
+{
+    struct can_priv *priv =3D netdev_priv(dev);
+
+    if (unlikely(state =3D=3D priv->state)) {
+        netdev_warn(dev, "%s: oops, state did not change", __func__);
+        return;
+    }
+
+    can_update_error_counters(new_state);
+
+    if (unlikely(state =3D=3D CAN_STATE_BUS_OFF)) {
+        cf->can_id |=3D CAN_ERR_BUSOFF;
+    } else {
+        cf->can_id |=3D CAN_ERR_CRTL;
+        /* Absolute: */
+        cf->data[1] |=3D can_txstate_to_frame(tx_state)
+                 | can_rxstate_to_frame(rx_state);
+        /* Alternatively, the difference:
+         *  if (tx_state > rx_state)
+         *     cf->data[1] |=3D can_txstate_to_frame(tx_state);
+         *  if (tx_state < rx_state)
+         *     cf->data[1] |=3D can_rxstate_to_frame(rx_state);
+         *  else
+         *      cf->data[1] |=3D can_txstate_to_frame(tx_state)
+         *               | can_rxstate_to_frame(rx_state);
+         * Or even, disregarding the equal case:
+         *  cf->data[1] |=3D (tx_state > rx_state) ?
+         *      can_txstate_to_frame(tx_state) :
+         *      can_rxstate_to_frame(rx_state);
+         */
+
+    }
+
+    priv->state =3D state;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
  /*
   * Local echo of CAN messages
   *

>> But this is all based on the premise that txerr hasn't progressed si=
nce.
>> In fact,
>> because we cannot assume that txerr stays in place until rxerr catch=
es
>> up, this
>> is what we should be doing:
>> enum can_state errcount_to_state(unsigned int count)
>> {
>>      if (unlikely(count > 127))
>>          return CAN_STATE_ERROR_PASSIVE;
>>
>>      if (unlikely(count > 96))
>>          return CAN_STATE_ERROR_WARNING;
>>
>>      return CAN_STATE_ERROR_ACTIVE;
>> }
>>
>> enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rx=
err)
>> {
>>      enum can_err_dir dir;
>>
>>      enum can_state tx_state =3D errcount_to_state(txerr);
>>      enum can_state rx_state =3D errcount_to_state(rxerr);
>>
>>      if (tx_state > rx_state)
>>          return CAN_ERR_DIR_TX;
>>
>>      if (tx_state < rx_state)
>>          return CAN_ERR_DIR_RX;
>>
>>      return CAN_ERR_DIR_TX | CAN_ERR_DIR_RX;
>> }
>>
>> However, now that we've introduced errcount_to_state(), it seems to =
me
>> that it would
>> be simpler to dump the proposed CAN_ERR_DIR enum in favour of passin=
g
>> the two states
>> directly to can_change_state().
> D'accord.
>
>>
>>> To validate the correct behaviour could you please send messages wh=
ile
>>> the cable is disconnected. Then reconnect the cable and see how the
>>> error state decreases. You can monitor the behaviour with ""candump=
 -td
>>> -e any,0:0,#FFFFFFFF" in another shell.
>>>
>> I'm using PCAN-USB Pro to generate errors on the bus. It works quite=
 well.
>> I can generate tx errors by sending from the device and then have th=
e pcan
>> ruin a few frames. rx errors can be generated by having an other dev=
ice on
>> the bus outputting random data and then let the pcan corrupt the fra=
mes.
> Short-circuiting the CAN low and high lines is a simple method to
Ahh, yes, I tried that too. That's what triggered bus-off. I got it=20
mixed up in
my head. :)
>> Sadly the error generation mechanism only works on windows. :(
>>
>> I've tried the "disconnected cable" method too in the past. It usual=
ly
>> puts mscan into bus-off quite fast.
> Sending a message whithout cable should never trigger an bus-off. The=
 tx
> error counter never exceeds 128.
>
> Here is an example output of "candump -candump -td -e any,0:0,#FFFFFF=
=46F"
> for a recovery from error passive state due to no ack/cable (reconnec=
t
> after 5s) for a SJA1000 on an on EMS PCI card:
>
>   (000.201913)  can0   1C  [0]
>   (000.212241)  can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFR=
AME
>          controller-problem{tx-error-warning}
>          state-change{tx-error-warning}
>          error-counter-tx-rx{{96}{0}}
>   (000.003544)  can0  20000204  [8] 00 20 00 00 00 00 80 00   ERRORFR=
AME
>          controller-problem{tx-error-passive}
>          state-change{tx-error-passive}
>          error-counter-tx-rx{{128}{0}}
>   (004.901842)  can0   1D  [7] 1D F6 33 52 31 4B DE
>   (000.000116)  can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFR=
AME
>          state-change{tx-error-warning}
>          error-counter-tx-rx{{127}{0}}
>   (000.000678)  can0   1E  [6] 42 05 14 82 23 B6
>   ...
>   (000.201927)  can0   49  [4] 2F 1A 97 25
>   (000.000096)  can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFR=
AME
>          state-change{back-to-error-active}
>          error-counter-tx-rx{{95}{0}}
>   (000.202184)  can0   4A  [8] 7F 87 0E FE 03 BA 78 91
>
> This is from my related patch-set.
>
Okay, I'll try that but the -e flag won't help much because candump exp=
ects
the PROT abuse.

Andri

PS.: I must admit that I don't actually know why it's useful to know wh=
ich
error counter changed; tx or rx. I think it would be much simpler to se=
nd
the max of both and be done with it. Can anyone point out a case where =
this
helps?
