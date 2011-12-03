From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: Re: RFC: improve and consolidate state change and bus-off handling
Date: Sat, 03 Dec 2011 11:18:56 +0100
Message-ID: <4ED9F790.2060308@hartkopp.net>
References: <4ED8948E.5090806@grandegger.com> <4ED89D50.9040401@pengutronix.de>
	<4ED9EBAB.4060701@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED9EBAB.4060701-xpvPi5bcW5W9w4jpWW8B1qHonnlKzd3f@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Sebastian Haas <dev-xpvPi5bcW5W9w4jpWW8B1qHonnlKzd3f@public.gmane.org>
Cc: SocketCAN Core Mailing List <socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linux-can Mailing List <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hello Sebastian,

nice to read that you're back on air ;-)

On 03.12.2011 10:28, Sebastian Haas wrote:

> Hello,
> 
> Am 02.12.2011 10:41, schrieb Marc Kleine-Budde:
>> On 12/02/2011 10:04 AM, Wolfgang Grandegger wrote:
>>> - Bus-off recovery:
>>>
>>>    Currently, I think, we do not handle bus-off recovery correctly for
>>>    most controllers. We brute-force stop and restart the controller.
>>>    The controller will do the recovery cycle anyway and we may send
>>>    messages to early. Instead the software should handle the bus-off
>>>    recovery cycle as shown below:
>>>
>>>    * bus-off happens
>>>      - call netif_stop_queue() and maybe disable interrupts
>>>
>>>    * automatic or manual restart is done
> Short note from me about that. We should be carefully with automatic recovery
> at driver-level, since this is basically not covered by the standard (only the
> application is allowed to decide whether or not the controller shall go back
> to error active). A bus off is an unusual state in a CAN network, because if
> this happens the network is physically in a bad shape (cable length, stub
> lines, electrical defects) or has a logical error (identifier conflicts,
> different bit-rates). So in my opinion the driver shall not allow anyway of
> automatic recovery and shall be up to the application to decide what to do.


You are right. For that reason the automatic restart is an option. You're
still able to define one handler on the multi-user system to cope with
bus-off. OTOH you can enable the automatic recovery when you know that you are
working in a proved CAN setup (regarding cable & bittiming issues) to handle
other temporary issues (EMC/hotplug). E.g. in some vehicle setups an automatic
recovery from bus-off after 200ms is specified. If this is done by a 'special'
handler or just by the driver can not be seen from the network view.

> 
>>>      - trigger bus-off recovery sequence by resetting the init bit
>>>        (on SJA1000) and maybe re-enable the interrupts
>>>      - await the controller going back to error-active state
>>>        (signaled via interrupt).
>>
>> I'm not sure if all controllers signal correctly that they are back in
>> error active. My observation is that bus off handling is a bit like
>> climbing the mount Everest, the air is quite thin and things can lock up
>> quite fast.
> In a worst case you need to poll for the error state if the controller doesn't
> support correct signalling. But I expect most controllers to implement such a
> feature since this is quite essential for most application to know the
> controller got bus-on/error active.


Yes. Indeed some CAN controllers recover themselves (IIRC mscan) and others
don't (SJA1000).  If a controller recovers silently (and no CAN frames come
from the outside to detect it) the state would need to be polled to be able to
send frames from the local host ...

> 
>>>      - call netif_wake_queue()
>>>
>>>    Here is a "candump -e" output for the SJA1000 (with delta times)
>>>
>>>      (009.832477)  can0  20000204  [8] 00 30 00 00 00 00 88 00   ERRORFRAME
>>>     controller-problem{tx-error-passive}
>>>     state-change{tx-error-passive}
>>>     error-counter-tx-rx{{136}{0}}
>>>      (000.000804)  can0  20000240  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
>>>     bus-off
>>>     state-change{}
>>>     error-counter-tx-rx{{127}{0}}
>>>      (000.099795)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
>>>     restarted-after-bus-off
>>>     error-counter-tx-rx{{127}{0}}
>>>      (000.003061)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRA
>>>     state-change{back-to-error-active}
>>>
>>>     Before doing all the necessary code changes, which are not always
>>>     trivial I ask: Would that be the correct bus-off handling???
>>
>> However if hardware permits the described steps sound reasonable (from
>> my non CAN expert point of view).


To me too. Nice rework idea.

> Despite the fact that you misuse a CAN message structure to carry CAN error
> frames, the overall procedure looks quite good.


From a todays view the CAN controller states could also be transferred into
the userspace by using recvmsg() that currently supports to push the timestamp
and the dropcounter within one syscall to the user.

The idea to get the error message through the data path (when it's enabled
with a special filter) is, that the CAN controller states fit into the logfile
and have their own timestamps - even when there's no valid CAN frame
receiption in that time. E.g. if you look into some Vector ASC logfiles the
problems detected by the CAN controller are also put inside the log at the
appropriate place. The reception of CAN data and CAN controller states in-line
with timestamps has real debugging advantages. Although it's easy to implement
in the interrupt handler whether you have a correct RX-interrupt or an error
interrupt -> you create a skb and push it into the system :-)

Regards,
Oliver
