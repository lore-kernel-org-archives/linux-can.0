From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Stuck vcan
Date: Tue, 11 Mar 2014 14:54:21 -0700
Message-ID: <CANGgnMZcwWiepdoZdeqWUhmfps89N_LRxHzfzT0Y8Z53o-ne3w@mail.gmail.com>
References: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>
	<531EB5A4.1090302@hartkopp.net>
	<CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
	<531F7899.3010205@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba61427844bf5404f45bc372
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:57101 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbaCKVyW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 17:54:22 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so9624832iec.4
        for <linux-can@vger.kernel.org>; Tue, 11 Mar 2014 14:54:22 -0700 (PDT)
In-Reply-To: <531F7899.3010205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

--90e6ba61427844bf5404f45bc372
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Mar 11, 2014 at 1:56 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 03/11/2014 09:37 PM, Austin Schuh wrote:
>> I'm not trying to cause problems ;)
>
> :D
>
>> Neither of those helped.
>>
>> # ifconfig vcan0
>> vcan0     Link encap:UNSPEC  HWaddr
>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>           RX packets:428406 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:428406 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:0
>>           RX bytes:3427248 (3.2 MiB)  TX bytes:3427248 (3.2 MiB)
>>
>> # ip link show vcan0
>> 17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
>> mode DEFAULT
>>     link/can
>>
>> # ifconfig vcan0
>> vcan0     Link encap:UNSPEC  HWaddr
>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>           RX packets:1400094 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:1400094 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:10
>>           RX bytes:11200752 (10.6 MiB)  TX bytes:11200752 (10.6 MiB)
>>
>> # ip link show vcan0
>> 17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
>> mode DEFAULT qlen 10
>>     link/can
>>
>> Both times, I get the following.
>>
>> Mar 11 13:28:58 aschuh-peloton kernel: [96229.460901] Dead loop on
>> virtual device vcan0, fix it urgently!
>> Mar 11 13:28:59 aschuh-peloton kernel: [96230.313875] Dead loop on
>> virtual device vcan0, fix it urgently!
>> Mar 11 13:28:59 aschuh-peloton kernel: [96230.319494] Dead loop on
>> virtual device vcan0, fix it urgently!
>> Mar 11 13:29:00 aschuh-peloton kernel: [96231.072617] Dead loop on
>> virtual device vcan0, fix it urgently!
>>
>> Luckily, it is easy to reproduce.  I have some trivial code which
>> sends out 10,000 msgs/sec on the vcan.  I run 3+ copies of the code on
>> a dual core machine with hyperthreads enabled.  More parallel sends
>> should cause it to occur more frequently.
>
> Can you share the code?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>

The attached code reproduces the problem for me.  I removed all the
extra dependencies.

Austin

--90e6ba61427844bf5404f45bc372
Content-Type: text/x-c++src; charset=US-ASCII; name="bus_load_linux_can.cc"
Content-Disposition: attachment; filename="bus_load_linux_can.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hsnpt3rp1

I2luY2x1ZGUgPGxpbnV4L2Nhbi5oPgojaW5jbHVkZSA8bGludXgvY2FuL3Jhdy5oPgojaW5jbHVk
ZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxuZXQvaWYuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoj
aW5jbHVkZSA8YXNzZXJ0Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+
CgojaW5jbHVkZSA8c3RyaW5nPgojaW5jbHVkZSA8aW9zdHJlYW0+CgovLyBBIGNhbiBidXMgd2hp
Y2ggc2VuZHMgdXNpbmcgU29ja2V0Q2FuIHRvIHRoZSBzcGVjaWZpZWQgaW50ZXJmYWNlLgpjbGFz
cyBTb2NrZXRDYW5CdXMgewogcHVibGljOgogIGV4cGxpY2l0IFNvY2tldENhbkJ1cyhjb25zdCA6
OnN0ZDo6c3RyaW5nICZpZmFjZSkgOiBpZmFjZV8oaWZhY2UpIHt9CgogIH5Tb2NrZXRDYW5CdXMo
KSB7CiAgICBpZiAoc29ja2V0XyAhPSAtMSkgewogICAgICBjbG9zZShzb2NrZXRfKTsKICAgIH0K
ICB9CgogIHZvaWQgSW5pdGlhbGl6ZSgpOwogIGJvb2wgU2VuZChjb25zdCBzdHJ1Y3QgY2FuX2Zy
YW1lICZmcmFtZSkKICAgICAgX19hdHRyaWJ1dGVfXygod2Fybl91bnVzZWRfcmVzdWx0KSk7Cgog
cHJpdmF0ZToKICAvLyBUaGUgc29ja2V0LgogIGludCBzb2NrZXRfOwogIDo6c3RkOjpzdHJpbmcg
aWZhY2VfOwp9OwoKdm9pZCBTb2NrZXRDYW5CdXM6OkluaXRpYWxpemUoKSB7CiAgc29ja2V0XyA9
IHNvY2tldChQRl9DQU4sIFNPQ0tfUkFXLCBDQU5fUkFXKTsKICBzdHJ1Y3Qgc29ja2FkZHJfY2Fu
IGFkZHI7CiAgc3RydWN0IGlmcmVxIGlmcjsKICBhc3NlcnQoc29ja2V0XyA+PSAwKTsKCiAgc3Ry
Y3B5KGlmci5pZnJfbmFtZSwgaWZhY2VfLmNfc3RyKCkpOwogIGFzc2VydChpb2N0bChzb2NrZXRf
LCBTSU9DR0lGSU5ERVgsICZpZnIpID09IDApOwoKICAvLyBaZXJvIGluaXRpYWxpemUgdGhlIHNv
Y2thZGRyLCBtYWlubHkgZm9yIHZhbGdyaW5kLCBidXQgaXQgY2FuJ3QgaHVydC4KICBzdHJ1Y3Qg
c29ja2FkZHIgKm15X3NvY2thZGRyX2NhbiA9IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcjsKICBt
ZW1zZXQobXlfc29ja2FkZHJfY2FuLT5zYV9kYXRhLCAwLCBzaXplb2YobXlfc29ja2FkZHJfY2Fu
LT5zYV9kYXRhKSk7CgogIGFkZHIuY2FuX2ZhbWlseSA9IEFGX0NBTjsKICBhZGRyLmNhbl9pZmlu
ZGV4ID0gaWZyLmlmcl9pZmluZGV4OwoKICA6OnN0ZDo6Y291dCA8PCAiQ29ubmVjdGluZyB0byAi
IDw8IGlmYWNlXyA8PCA6OnN0ZDo6ZW5kbDsKCiAgYXNzZXJ0KGJpbmQoc29ja2V0XywgKHN0cnVj
dCBzb2NrYWRkciAqKSZhZGRyLCBzaXplb2YoYWRkcikpID09IDApOwp9Cgpib29sIFNvY2tldENh
bkJ1czo6U2VuZChjb25zdCBzdHJ1Y3QgY2FuX2ZyYW1lICZmcmFtZSkgewogIGFzc2VydChzb2Nr
ZXRfICE9IC0xKTsKICByZXR1cm4gd3JpdGUoc29ja2V0XywgJmZyYW1lLCBzaXplb2Yoc3RydWN0
IGNhbl9mcmFtZSkpID09CiAgICAgICAgIHNpemVvZihzdHJ1Y3QgY2FuX2ZyYW1lKTsKfQoKaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkgewogIFNvY2tldENhbkJ1cyBidXMoInZjYW4w
Iik7CiAgYnVzLkluaXRpYWxpemUoKTsKCiAgd2hpbGUgKHRydWUpIHsKICAgIHVzbGVlcCgxMDAw
MDAwIC8gMTAwMDApOwogICAgc3RydWN0IGNhbl9mcmFtZSBmcmFtZTsKICAgIGZyYW1lLmNhbl9p
ZCA9IDB4MTAwOwogICAgZnJhbWUuY2FuX2RsYyA9IDg7CiAgICBmb3IgKGludCBpID0gMDsgaSA8
IDg7ICsraSkgewogICAgICBmcmFtZS5kYXRhW2ldID0gaTsKICAgIH0KICAgIGlmICghYnVzLlNl
bmQoZnJhbWUpKSB7CiAgICAgIDo6c3RkOjpjb3V0IDw8ICJGYWlsZWQgdG8gc2VuZCB0aGUgQ0FO
IGZyYW1lLiIgPDwgOjpzdGQ6OmVuZGw7CiAgICB9CiAgfQogIHJldHVybiAwOwp9Cg==
--90e6ba61427844bf5404f45bc372--
