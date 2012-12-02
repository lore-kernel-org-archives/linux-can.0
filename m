From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Sun, 2 Dec 2012 12:45:49 +0100
Message-ID: <FE2FD5CC-E6D8-4003-863E-AF346A836D7D@eia.be>
References: <50BB1E8E.10809@universalnet.at> <50BB2F36.3040303@hartkopp.net>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:5609 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753292Ab2LBLpp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 2 Dec 2012 06:45:45 -0500
In-Reply-To: <50BB2F36.3040303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "krumboeck@universalnet.at" <krumboeck@universalnet.at>, linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hello,
>> 
>> +/* Get statistic values */
>> +static ssize_t show_statistics(struct device *d, struct device_attribute *attr,
>> +                   u8 statistic, char *buf)
>> +{
>> +    struct usb2can_cmd_msg    outmsg;
>> +    struct usb2can_cmd_msg    inmsg;
>> +    int err = 0;
>> +    u32 *value;
>> +    u32 result;
>> +    struct usb_interface *intf = to_usb_interface(d);
>> +    struct usb2can *dev = usb_get_intfdata(intf);
>> +
>> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
>> +    outmsg.command = USB2CAN_GET_STATISTICS;
>> +    outmsg.opt1 = statistic;
>> +
>> +    err = usb2can_send_cmd(dev, &outmsg, &inmsg);
>> +    if (err)
>> +        return -EIO;
>> +
>> +    value = (u32 *) inmsg.data;
>> +    result = be32_to_cpu(*value);
>> +
>> +    return sprintf(buf, "%d\n", result);
>> +}
>> +
>> +static ssize_t show_rx_frames(struct device *d, struct device_attribute *attr,
>> +                  char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_RX_FRAMES, buf);
>> +}
>> +
>> +static ssize_t show_rx_bytes(struct device *d, struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_RX_BYTES, buf);
>> +}
>> +
>> +static ssize_t show_tx_frames(struct device *d, struct device_attribute *attr,
>> +                  char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_TX_FRAMES, buf);
>> +}
>> +
>> +static ssize_t show_tx_bytes(struct device *d, struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_RX_BYTES, buf);
>> +}
>> +
>> +static ssize_t show_overruns(struct device *d, struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_OVERRUNS, buf);
>> +}
>> +
>> +static ssize_t show_warnings(struct device *d, struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_WARNINGS, buf);
>> +}
>> +
>> +static ssize_t show_bus_off(struct device *d, struct device_attribute *attr,
>> +                char *buf)
>> +{
>> +    return show_statistics(d, attr, USB2CAN_STAT_BUS_OFF, buf);
>> +}
>> +
>> +/* Reset statistics */
>> +static ssize_t reset_statistics(struct device *d, struct device_attribute *attr,
>> +                const char *buf, size_t count)
>> +{
>> +    struct usb2can_cmd_msg    outmsg;
>> +    struct usb2can_cmd_msg    inmsg;
>> +    int err = 0;
>> +    struct usb_interface *intf = to_usb_interface(d);
>> +    struct usb2can *dev = usb_get_intfdata(intf);
>> +
>> +    if (buf[0] == '1') {
>> +        memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
>> +        outmsg.command = USB2CAN_GET_STATISTICS;
>> +        outmsg.opt1 = USB2CAN_STAT_RESET_STAT;
>> +
>> +        err = usb2can_send_cmd(dev, &outmsg, &inmsg);
>> +        if (err)
>> +            return -EIO;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +/* Get "disable automatic retransmission" flag */
>> +static ssize_t show_dar(struct device *d, struct device_attribute *attr,
>> +            char *buf)
>> +{
>> +    struct usb_interface *intf = to_usb_interface(d);
>> +    struct usb2can *dev = usb_get_intfdata(intf);
>> +
>> +    return sprintf(buf, "%d\n", dev->dar);
>> +}
>> +
>> +/* Set "disable automatic retransmission" flag */
>> +static ssize_t set_dar(struct device *d, struct device_attribute *attr,
>> +               const char *buf, size_t count)
>> +{
>> +    struct usb_interface *intf = to_usb_interface(d);
>> +    struct usb2can *dev = usb_get_intfdata(intf);
>> +
>> +    if (dev->can.state != CAN_STATE_STOPPED) {
>> +        dev_err(&intf->dev,
>> +            "DAR flag can only be set when device is stopped\n");
>> +        return -EIO;
>> +    }
>> +
>> +    if (buf[0] == '0')
>> +        dev->dar = 0;
>> +    else if (buf[0] == '1')
>> +        dev->dar = 1;
>> +    else
>> +        return -EIO;
>> +
>> +    return count;
>> +}
>> +
>> +static DEVICE_ATTR(firmware, S_IRUGO, show_firmware, NULL);
>> +static DEVICE_ATTR(hardware, S_IRUGO, show_hardware, NULL);
>> +static DEVICE_ATTR(can_state, S_IRUGO, show_status, NULL);
>> +static DEVICE_ATTR(can_rx_frames, S_IRUGO, show_rx_frames, NULL);
>> +static DEVICE_ATTR(can_rx_bytes, S_IRUGO, show_rx_bytes, NULL);
>> +static DEVICE_ATTR(can_tx_frames, S_IRUGO, show_tx_frames, NULL);
>> +static DEVICE_ATTR(can_tx_bytes, S_IRUGO, show_tx_bytes, NULL);
>> +static DEVICE_ATTR(can_overruns, S_IRUGO, show_overruns, NULL);
>> +static DEVICE_ATTR(can_warnings, S_IRUGO, show_warnings, NULL);
>> +static DEVICE_ATTR(can_bus_off_counter, S_IRUGO, show_bus_off, NULL);
> 
> 
> I don't think that creating all these files are a good idea.
> Probably there is a more generic approach for that.
> 
> Let's wait for other peoples feedback.
Statistics are exported already via 'ip link'. What is the added value
of these sysfs?

Kurt?