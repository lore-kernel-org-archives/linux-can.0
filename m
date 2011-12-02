From: Wolfgang Grandegger <wg@grandegger.com>
Subject: RFC: improve and consolidate state change and bus-off handling
Date: Fri, 02 Dec 2011 10:04:14 +0100
Message-ID: <4ED8948E.5090806@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34858 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab1LBJET (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 04:04:19 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-can Mailing List <linux-can@vger.kernel.org>, SocketCAN Core Mailing List <socketcan-core@lists.berlios.de>

Hello,

as you might know, our handling of CAN state changes and bus-off is
not consistent, weak or even incorrect. Therefore I'm making an effort
to improve, consolidate and *unify* it. Most things are straight-
forward, but others need more attention and especially for the bus-off
recovery I would appreciate some CAN expert advice (more below). I have
already some patches implementing:

- Add missing do_get_berr_counter() callbacks (for ti_hecc, etc.).

- Add error counters to the data fields 6..7 of *any* CAN error message
  automatically in alloc_can_err_skb():

       if (priv->do_get_berr_counter) {
               struct can_berr_counter bec;

               priv->do_get_berr_counter(dev, &bec);
               (*cf)->data[6] = bec.txerr;
               (*cf)->data[7] = bec.rxerr;
       }

- Allow state changes going down including "back to error active":

  Therefore I added:

    $ cat include/linux/can/error.h
    ...
    #define CAN_ERR_STATE_CHANGE 0x00000200U /* CAN error state change / data[1] */
    ...
    #define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */
 
  For any state change the CAN_ERR_STATE_CHANGE will be set in the
  can_id. If the state gets worse, CAN_ERR_CRTL is set as usual
  also for backward compatibility. The state change management will
  be done by a common "can_change_state()" function doing all the bit
  settings and counter increments. For the SJA1000 "candump -e" will
  then report for recovery from the error passive state (no cable):

    can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
	controller-problem{tx-error-warning}
	state-change{tx-error-warning}
	error-counter-tx-rx{{96}{0}}
    can0  20000204  [8] 00 30 00 00 00 00 80 00   ERRORFRAME
	controller-problem{tx-error-passive}
	state-change{tx-error-passive}
	error-counter-tx-rx{{128}{0}}
    can0  124  [3] 12 34 56
    ...
    can0  124  [3] 12 34 56
    can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
	state-change{tx-error-warning}
	error-counter-tx-rx{{127}{0}}
    can0  124  [3] 12 34 56
    ...
    can0  124  [3] 12 34 56
    can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
	state-change{back-to-error-active}
	error-counter-tx-rx{{95}{0}}
 
   Updating all drivers correctly is a challenge, especially because I
   do not have all hardware. Help and comments are appreciated.

- Bus-off recovery:

  Currently, I think, we do not handle bus-off recovery correctly for
  most controllers. We brute-force stop and restart the controller.
  The controller will do the recovery cycle anyway and we may send
  messages to early. Instead the software should handle the bus-off
  recovery cycle as shown below:

  * bus-off happens
    - call netif_stop_queue() and maybe disable interrupts

  * automatic or manual restart is done
    - trigger bus-off recovery sequence by resetting the init bit
      (on SJA1000) and maybe re-enable the interrupts
    - await the controller going back to error-active state
      (signaled via interrupt).
    - call netif_wake_queue()

  Here is a "candump -e" output for the SJA1000 (with delta times)

    (009.832477)  can0  20000204  [8] 00 30 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	state-change{tx-error-passive}
	error-counter-tx-rx{{136}{0}}
    (000.000804)  can0  20000240  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
	bus-off
	state-change{}
	error-counter-tx-rx{{127}{0}}
    (000.099795)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
	restarted-after-bus-off
	error-counter-tx-rx{{127}{0}}
    (000.003061)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
	state-change{back-to-error-active}

   Before doing all the necessary code changes, which are not always
   trivial I ask: Would that be the correct bus-off handling???

Thanks for feedback.

Wolfgang.
