From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Mon, 21 Oct 2013 11:51:20 +0200
Message-ID: <5264F918.1050408@kkmicro.cz>
References: <l3r0ki$hde$1@ger.gmane.org> <526113A1.8020403@kkmicro.cz> <526148E9.4040406@hartkopp.net> <5264CFA6.9050805@kkmicro.cz> <07b96b822a3778b2279d78b90cda3908@grandegger.com> <9d0a209e86731f7a68f84dbdc52124cc@grandegger.com> <5264EBB9.3010803@kkmicro.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.aquastore.cz ([37.157.193.242]:49518 "EHLO
	server.aquastore.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3JUJva (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Oct 2013 05:51:30 -0400
Received: from localhost (unknown [127.0.0.1])
	by server.aquastore.cz (Postfix) with ESMTP id 59F32ABC0D
	for <linux-can@vger.kernel.org>; Mon, 21 Oct 2013 09:51:25 +0000 (UTC)
Received: from server.aquastore.cz ([127.0.0.1])
	by localhost (server.aquastore.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZNOnJ3T-Ru_0 for <linux-can@vger.kernel.org>;
	Mon, 21 Oct 2013 11:51:21 +0200 (CEST)
Received: from [127.0.0.1] (unknown [213.191.105.242])
	by server.aquastore.cz (Postfix) with ESMTPSA id 9D2B4ABBF7
	for <linux-can@vger.kernel.org>; Mon, 21 Oct 2013 11:51:21 +0200 (CEST)
In-Reply-To: <5264EBB9.3010803@kkmicro.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 21.10.2013 10:54, Martin Kozusky napsal(a):
> Dne 21.10.2013 10:11, Wolfgang Grandegger napsal(a):
>> My previous mail went out to early, sorry... completing it now...
>>
>>
>>
>> On Mon, 21 Oct 2013 10:00:28 +0200, Wolfgang Grandegger
>>
>> <wg@grandegger.com> wrote:
>>
>>> On Mon, 21 Oct 2013 08:54:30 +0200, Martin Kozusky <mkozusky@kkmicro.cz>
>>
>>> wrote:
>>
>>>> Dne 18.10.2013 16:42, Oliver Hartkopp napsal(a):
>>
>>>>> On 18.10.2013 12:55, Martin Kozusky wrote:
>>
>>>>>>
>>
>>>>>> Dne 18.10.2013 11:56, Martin Kozusky napsal(a):
>>
>>>>>>> Hello,
>>
>>>>>>> is there any official way how to read timestamp from flexcans
>>
>> message
>>
>>>>>>> buffer?
>>
>>>>>>> I see there is a macro defined FLEXCAN_MB_CNT_TIMESTAMP in
>>
>> flexcan.c,
>>
>>>>>>> but not used.
>>
>>>>>>> I would modify function flecan_read_fifo like
>>
>>>>>>>
>>
>>>>>>> + u32 timestamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);
>>
>>>>>>
>>
>>>>>> sorry, u32 should be just u16
>>
>>>>>>
>>
>>>>>>> but what to do with timestamp variable next and how to read it in
>>
>>>>>>> userspace? :) I could change structure can_frame and add  u32
>>
>>> timestamp
>>
>>>>>> also u16, not u32
>>
>>>>>>
>>
>>>>>>> into it, but it wouldn't be very nice hack I think.
>>
>>>>>>>
>>
>>>>>>> BTW: is timestamp read with SO_TIMESTAMP  actualy taken when CAN
>>
>>>>>>> message
>>
>>>>>>> arrives?
>>
>>>>>>>
>>
>>>>>
>>
>>>>> Hello Martin,
>>
>>>>>
>>
>>>>> with SO_TIMESTAMP you get the system timestamp in nanosec resolution.
>>
>>>>>
>>
>>>>> It is set at the time when the CAN frame is pushed to the network
>>
>> layer
>>
>>>>> by
>>
>>>>> the CAN drivers interrupt routine.
>>
>>>>>
>>
>>>>> See net_timestamp_check() in netif_rx():
>>
>>>>>
>>
>>>>>
>>
>>>
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/core/dev.c#n3228
>>
>>
>>>> Hello Oliver,
>>
>>>> I'm already using SO_TIMESTAMP with recvmmsg so may be I should switch
>>
>>>> to SO_TIMESTAMPNS for better times, right?
>>
>>>>
>>
>>>>> You may get this timestamp via ioctl() or recvmsg().
>>
>>>>>
>>
>>>>> To pass hardware timestamps there's some infrastructure for ethernet
>>
>>>>> devices in the
>>
>>>>> mainlaine kernel, which is configured with "ethtool":
>>
>>>>>
>>
>>>>>      ethtool -T|--show-time-stamping DEVNAME    Show time stamping
>>
>>>>>      capabilities
>>
>>>>>
>>
>>>>> See details at
>>
>>>>>
>>
>>>>>
>>
>>>
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/timestamping.txt
>>
>>
>>>>>
>>
>>>>> And some example source code at
>>
>>>>>
>>
>>>>>
>>
>>>
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/timestamping/timestamping.c
>>
>>
>>>>>
>>
>>>>> There needs to be added some infrastructure to the network devices to
>>
>>>>> query
>>
>>>>> and configure the timestamping possibilities.
>>
>>>>>
>>
>>>>> This is currently missing for CAN devices ...
>>
>>>>>
>>
>>>>> Even if I moved a wrongly assigned hardware timestamp to another place
>>
>>>>> here:
>>
>>>>>
>>
>>>>>
>>
>>>
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/usb/peak_usb?id=c9faaa09e2a1335678f09c70a0d0eda095564bab
>>
>>
>>>>>
>>
>>>>> the rest of the hardware timestamping (& configuration) is still
>>
>>> missing.
>>
>>
>>
>> Supporting SIOCSHWTSTAMP seem the right way to go.
>>
>>
>>
>>>>
>>
>>>> So I could just do
>>
>>>>
>>
>>>>    struct skb_shared_hwtstamps *hwts;
>>
>>>>    hwts = skb_hwtstamps(skb);
>>
>>
>>
>> Most drivers do as well:
>>
>>
>>
>>   memset(hwts, 0, sizeof(*hwts));
>>
>>
>>
>>>>    hwts->hwtstamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);
>>
>>
>>
>> This should assign a proper ktime. [nm]s_to_ktime() may help.
>
> But value read from registers is just 16bit value having nothing to do
> with real time. But now when I see the ns_to_ktime function, it will
> just assign my 16bit value to .tv64 union member, ok I will use it.
>
> But I see another problem here:
>   flexcan registers are read in function flexcan_read_fifo but I need to
> know the timestamp in function flexcan_read_frame, how do I transfer it
> from there?
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/flexcan.c#n519
>
>
> Should I just create some global variable in flexcan.c and store the
> 16bit value into it and then use it?
>
>
>>
>>>> in  flecan_read_fifo ?
>>
>>>>
>>
>>>> And then how to read it?
>>
>>>
>>
>>> See:
>>
>>>
>>
>>>
>>
>> http://lxr.free-electrons.com/source/Documentation/networking/timestamping/
>>
>>
>>
>>
>> This also shows how to do read the timestamp.
>>
>
>
> So you mean this setup:
>
>
>    memset(&hwtstamp, 0, sizeof(hwtstamp));
>    strncpy(hwtstamp.ifr_name, interface, sizeof(hwtstamp.ifr_name));
>    hwtstamp.ifr_data = (void *)&hwconfig;
>    memset(&hwconfig, 0, sizeof(hwconfig));
>    hwconfig.tx_type = HWTSTAMP_TX_OFF;
>    hwconfig.rx_filter = HWTSTAMP_FILTER_ALL;
>    hwconfig_requested = hwconfig;
>    if (ioctl(sock, SIOCSHWTSTAMP, &hwtstamp) < 0) {
>       if ((errno == EINVAL || errno == ENOTSUP) &&
>           hwconfig_requested.tx_type == HWTSTAMP_TX_OFF &&
>           hwconfig_requested.rx_filter == HWTSTAMP_FILTER_NONE)
>         printf("SIOCSHWTSTAMP: disabling hardware time stamping not
> possible\n");
>       else
>         bail("SIOCSHWTSTAMP");
>    }
>   printf("SIOCSHWTSTAMP: tx_type %d requested, got %d; rx_filter %d
> requested, got %d\n",
>   hwconfig_requested.tx_type, hwconfig.tx_type,
>   hwconfig_requested.rx_filter, hwconfig.rx_filter);

When I do
  ioctl(sock, SIOCSHWTSTAMP, &hwtstamp) it returns ENOTSUP :( do I have 
to define this ioctl somehow in the flexcan driver or somewhere else?

Martin

>
> and read from this cmsg_type:
>
> case SO_TIMESTAMPING: {
>    struct scm_timestamping *stamp =
>    (struct scm_timestamping *)CMSG_DATA(cmsg);
>      printf("SO_TIMESTAMPING ");
>      printf("HW raw %ld.%09ld",
>       (long)stamp->hwtimeraw->tv_sec,
>       (long)stamp->hwtimeraw->tv_nsec);
>   break;
> }
>
>
> or did I forget something?
>
> Thank you,
> Martin
>
>>
>>>>
>>
>>>> Or will it be easier for me just to change can_frame structure? :)
>>
>>>
>>
>>> No.
>>
>>
>>
>> Please use the forseen interface.
>>
>>
>>
>> Wolfgang
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

