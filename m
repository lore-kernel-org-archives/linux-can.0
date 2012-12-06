From: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Subject: Re: [PATCH v5] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Thu, 06 Dec 2012 20:40:20 +0100
Message-ID: <50C0F4A4.3030106@universalnet.at>
References: <1354785884-27030-1-git-send-email-krumboeck@universalnet.at> <CALiqQcp+t+WhvCGm0m4UJC-3do1U9njHX73p+4y-jsQktt_gEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALiqQcp+t+WhvCGm0m4UJC-3do1U9njHX73p+4y-jsQktt_gEg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Fisher <fishbot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi!


Am 2012-12-06 17:44, schrieb Shawn Fisher:
>     +static int usb_8dev_send_cmd(struct usb_8dev_priv *priv,
>
>     +                            struct usb_8dev_cmd_msg *out,
>     +                            struct usb_8dev_cmd_msg *in)
>     +{
>     +       int err;
>     +       int num_bytes_read;
>     +       struct net_device *netdev;
>     +
>     +       netdev = priv->netdev;
>     +
>     +       out->begin = USB_8DEV_CMD_START;
>     +       out->end = USB_8DEV_CMD_END;
>     +
>     +       mutex_lock(&priv->usb_8dev_cmd_lock);
>     +
>     +       memcpy(priv->cmd_msg_buffer, out,
>     +               sizeof(struct usb_8dev_cmd_msg));
>     +
>     +       err = usb_8dev_send_cmd_msg(priv, priv->cmd_msg_buffer,
>     +                                   sizeof(struct usb_8dev_cmd_msg));
>     +       if (err < 0) {
>     +               netdev_err(netdev, "sending command message failed\n");
>     +               return err;
>     +       }
>     +
>     +       err = usb_8dev_wait_cmd_msg(priv, priv->cmd_msg_buffer,
>     +                                   sizeof(struct usb_8dev_cmd_msg),
>     +                                   &num_bytes_read);
>     +       if (err < 0) {
>     +               netdev_err(netdev, "no command message answer\n");
>     +               return err;
>     +       }
>     +
>     +       memcpy(in, priv->cmd_msg_buffer, sizeof(struct usb_8dev_cmd_msg));
>     +
>     +       mutex_unlock(&priv->usb_8dev_cmd_lock);
>     +
>     +       if (in->begin != USB_8DEV_CMD_START || in->end != USB_8DEV_CMD_END ||
>     +                       num_bytes_read != 16 || in->opt1 != 0)
>     +               return -EPROTO;
>     +
>     +       return 0;
>     +}
>
>
> Don't forget to unlock that mutex when an error occurs.


Thanks! I will create a new patch in the next days.

In the meanwhile you can find the fixed version here: https://github.com/krumboeck/usb2can

regards,
Bernd

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
