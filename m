From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Thu, 7 Nov 2013 15:43:38 -0800
Message-ID: <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
	<CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
	<5254608B.4080208@grandegger.com>
	<CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
	<be0d6725fff5298d3fb8417e4800348b@grandegger.com>
	<CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>
	<84ba410d04a85a783d1c1994f98d1f31@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e013c6e4abb9dac04ea9ed5f1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:39294 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3KGXnj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Nov 2013 18:43:39 -0500
Received: by mail-ie0-f178.google.com with SMTP id to1so309537ieb.37
        for <linux-can@vger.kernel.org>; Thu, 07 Nov 2013 15:43:38 -0800 (PST)
In-Reply-To: <84ba410d04a85a783d1c1994f98d1f31@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

--089e013c6e4abb9dac04ea9ed5f1
Content-Type: text/plain; charset=ISO-8859-1

>>
>> The dump is attached.
>
> I do not see any sja1000_rx() calls. Either they never happen or more
> likely the trace is not long enough. Could you try with a larger buffer
> using "echo 20000 > buffer_size_kb"? I also do not see some pr_info()
> related functions at the end of the trace. Are you sure is has stopped
> (cat tracing_on or message in dmesg)?
>
> Also please do an "echo 0 > trace" to clear the trace content.
>
> Wolfgang.

Hi Wolfgang,

I'm pretty certain that the trace is long enough.  I tried again with
echo -e -n 100000 > buffer_size_kb and I still don't see any calls to
sja1000_rx.

I added some pr_info prints at the front of sja1000_rx and
sja1000_interrupt.  For each packet sent and then received, I see the
following.  The following lines are from me sending 4 packets.

Nov  7 15:35:52 vpc5 kernel: [   75.136107] Got an sja1000 interrupt.
Nov  7 15:35:52 vpc5 kernel: [   75.136123] Unhandled IRQ 18... stop tracing...
Nov  7 15:35:52 vpc5 kernel: [   75.136130] Got an sja1000 interrupt.
Nov  7 15:35:52 vpc5 kernel: [   75.136139] Received packet.
Nov  7 15:35:52 vpc5 kernel: [   75.136146] sja1000_rx
Nov  7 15:35:52 vpc5 kernel: [   75.136155] TX complete.
Nov  7 15:35:52 vpc5 kernel: [   75.136174] Returning IRQ_HANDLED
Nov  7 15:35:52 vpc5 kernel: [   75.136207] Returning IRQ_HANDLED


Nov  7 15:35:54 vpc5 kernel: [   77.215328] Got an sja1000 interrupt.
Nov  7 15:35:54 vpc5 kernel: [   77.215345] Got an sja1000 interrupt.
Nov  7 15:35:54 vpc5 kernel: [   77.215348] Unhandled IRQ 18... stop tracing...
Nov  7 15:35:54 vpc5 kernel: [   77.215355] Received packet.
Nov  7 15:35:54 vpc5 kernel: [   77.215360] sja1000_rx
Nov  7 15:35:54 vpc5 kernel: [   77.215394] TX complete.
Nov  7 15:35:54 vpc5 kernel: [   77.215410] Returning IRQ_HANDLED
Nov  7 15:35:54 vpc5 kernel: [   77.215418] Returning IRQ_HANDLED


Nov  7 15:35:57 vpc5 kernel: [   80.614289] Unhandled IRQ 18... stop tracing...
Nov  7 15:35:57 vpc5 kernel: [   80.614297] Got an sja1000 interrupt.
Nov  7 15:35:57 vpc5 kernel: [   80.614308] Got an sja1000 interrupt.
Nov  7 15:35:57 vpc5 kernel: [   80.614323] Received packet.
Nov  7 15:35:57 vpc5 kernel: [   80.614327] TX complete.
Nov  7 15:35:57 vpc5 kernel: [   80.614335] sja1000_rx
Nov  7 15:35:57 vpc5 kernel: [   80.614343] Returning IRQ_HANDLED
Nov  7 15:35:57 vpc5 kernel: [   80.614394] Returning IRQ_HANDLED


Nov  7 15:36:02 vpc5 kernel: [   84.991239] Got an sja1000 interrupt.
Nov  7 15:36:02 vpc5 kernel: [   84.991255] Got an sja1000 interrupt.
Nov  7 15:36:02 vpc5 kernel: [   84.991258] Unhandled IRQ 18... stop tracing...
Nov  7 15:36:02 vpc5 kernel: [   84.991266] Received packet.
Nov  7 15:36:02 vpc5 kernel: [   84.991269] sja1000_rx
Nov  7 15:36:02 vpc5 kernel: [   84.991303] TX complete.
Nov  7 15:36:02 vpc5 kernel: [   84.991320] Returning IRQ_HANDLED
Nov  7 15:36:02 vpc5 kernel: [   84.991326] Returning IRQ_HANDLED

I didn't rerun any traces, since my analysis of the syslog is that it
won't give you the information you are looking for without moving the
tracing_off call somewhere else.

Austin

--089e013c6e4abb9dac04ea9ed5f1
Content-Type: application/octet-stream; name="sja1000.c.diff"
Content-Disposition: attachment; filename="sja1000.c.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hnqn3xut0

KioqIC90bXAvc2phMTAwMC5jX29yaWcJMjAxMy0xMS0wNyAxNTozNzo1Ny4yMzgzMTE0NTYgLTA4
MDAKLS0tIHNqYTEwMDAuYwkyMDEzLTExLTA3IDE1OjI4OjI5LjU4NjMzNTUwOSAtMDgwMAoqKioq
KioqKioqKioqKioKKioqIDMzMCwzMzUgKioqKgotLS0gMzMwLDMzNiAtLS0tCiAgCXVpbnQ4X3Qg
ZHJlZzsKICAJY2FuaWRfdCBpZDsKICAJaW50IGk7CisgICBwcl9pbmZvKCJzamExMDAwX3J4XG4i
KTsKICAKICAJLyogY3JlYXRlIHplcm8nZWQgQ0FOIGZyYW1lIGJ1ZmZlciAqLwogIAlza2IgPSBh
bGxvY19jYW5fc2tiKGRldiwgJmNmKTsKKioqKioqKioqKioqKioqCioqKiA0OTMsNTAyICoqKioK
ICAJc3RydWN0IG5ldF9kZXZpY2Vfc3RhdHMgKnN0YXRzID0gJmRldi0+c3RhdHM7CiAgCXVpbnQ4
X3QgaXNyYywgc3RhdHVzOwogIAlpbnQgbiA9IDA7CiAgCiAgCS8qIFNoYXJlZCBpbnRlcnJ1cHRz
IGFuZCBJUlEgb2ZmPyAqLwohIAlpZiAocHJpdi0+cmVhZF9yZWcocHJpdiwgU0pBMTAwMF9JRVIp
ID09IElSUV9PRkYpCiAgCQlyZXR1cm4gSVJRX05PTkU7CiAgCiAgCWlmIChwcml2LT5wcmVfaXJx
KQogIAkJcHJpdi0+cHJlX2lycShwcml2KTsKLS0tIDQ5NCw1MDYgLS0tLQogIAlzdHJ1Y3QgbmV0
X2RldmljZV9zdGF0cyAqc3RhdHMgPSAmZGV2LT5zdGF0czsKICAJdWludDhfdCBpc3JjLCBzdGF0
dXM7CiAgCWludCBuID0gMDsKKyAgIHByX2luZm8oIkdvdCBhbiBzamExMDAwIGludGVycnVwdC5c
biIpOwogIAogIAkvKiBTaGFyZWQgaW50ZXJydXB0cyBhbmQgSVJRIG9mZj8gKi8KISAJaWYgKHBy
aXYtPnJlYWRfcmVnKHByaXYsIFNKQTEwMDBfSUVSKSA9PSBJUlFfT0ZGKSB7CiEgICAgIHByX2lu
Zm8oIklSUSBub25lIGF0IHN0YXJ0XG4iKTsKICAJCXJldHVybiBJUlFfTk9ORTsKKyAgIH0KICAK
ICAJaWYgKHByaXYtPnByZV9pcnEpCiAgCQlwcml2LT5wcmVfaXJxKHByaXYpOwoqKioqKioqKioq
KioqKioKKioqIDUwNiw1MTYgKioqKgogIAkJbisrOwogIAkJc3RhdHVzID0gcHJpdi0+cmVhZF9y
ZWcocHJpdiwgU0pBMTAwMF9TUik7CiAgCQkvKiBjaGVjayBmb3IgYWJzZW50IGNvbnRyb2xsZXIg
ZHVlIHRvIGh3IHVucGx1ZyAqLwohIAkJaWYgKHN0YXR1cyA9PSAweEZGICYmIHNqYTEwMDBfaXNf
YWJzZW50KHByaXYpKQogIAkJCXJldHVybiBJUlFfTk9ORTsKICAKISAJCWlmIChpc3JjICYgSVJR
X1dVSSkKICAJCQluZXRkZXZfd2FybihkZXYsICJ3YWtldXAgaW50ZXJydXB0XG4iKTsKICAKICAJ
CWlmIChpc3JjICYgSVJRX1RJKSB7CiAgCQkJLyogdHJhbnNtaXNzaW9uIGJ1ZmZlciByZWxlYXNl
ZCAqLwotLS0gNTEwLDUyNCAtLS0tCiAgCQluKys7CiAgCQlzdGF0dXMgPSBwcml2LT5yZWFkX3Jl
Zyhwcml2LCBTSkExMDAwX1NSKTsKICAJCS8qIGNoZWNrIGZvciBhYnNlbnQgY29udHJvbGxlciBk
dWUgdG8gaHcgdW5wbHVnICovCiEgCQlpZiAoc3RhdHVzID09IDB4RkYgJiYgc2phMTAwMF9pc19h
YnNlbnQocHJpdikpIHsKISAgICAgICBwcl9pbmZvKCJTSkExMDAwIElSUSBOb25lXG4iKTsKICAJ
CQlyZXR1cm4gSVJRX05PTkU7CisgICAgIH0KICAKISAJCWlmIChpc3JjICYgSVJRX1dVSSkgewoh
ICAgICAgIHByX2luZm8oIlNKQTEwMDAgV2FrZXVwIGludGVycnVwdC5cbiIpOwogIAkJCW5ldGRl
dl93YXJuKGRldiwgIndha2V1cCBpbnRlcnJ1cHRcbiIpOworICAgICB9CiAgCiAgCQlpZiAoaXNy
YyAmIElSUV9USSkgewogIAkJCS8qIHRyYW5zbWlzc2lvbiBidWZmZXIgcmVsZWFzZWQgKi8KKioq
KioqKioqKioqKioqCioqKiA1MTgsNTQ1ICoqKioKICAJCQkgICAgIShzdGF0dXMgJiBTUl9UQ1Mp
KSB7CiAgCQkJCXN0YXRzLT50eF9lcnJvcnMrKzsKICAJCQkJY2FuX2ZyZWVfZWNob19za2IoZGV2
LCAwKTsKICAJCQl9IGVsc2UgewogIAkJCQkvKiB0cmFuc21pc3Npb24gY29tcGxldGUgKi8KICAJ
CQkJc3RhdHMtPnR4X2J5dGVzICs9CiAgCQkJCQlwcml2LT5yZWFkX3JlZyhwcml2LCBTSkExMDAw
X0ZJKSAmIDB4ZjsKICAJCQkJc3RhdHMtPnR4X3BhY2tldHMrKzsKICAJCQkJY2FuX2dldF9lY2hv
X3NrYihkZXYsIDApOwogIAkJCX0KICAJCQluZXRpZl93YWtlX3F1ZXVlKGRldik7CiAgCQkJY2Fu
X2xlZF9ldmVudChkZXYsIENBTl9MRURfRVZFTlRfVFgpOwogIAkJfQogIAkJaWYgKGlzcmMgJiBJ
UlFfUkkpIHsKICAJCQkvKiByZWNlaXZlIGludGVycnVwdCAqLwogIAkJCXdoaWxlIChzdGF0dXMg
JiBTUl9SQlMpIHsKICAJCQkJc2phMTAwMF9yeChkZXYpOwogIAkJCQlzdGF0dXMgPSBwcml2LT5y
ZWFkX3JlZyhwcml2LCBTSkExMDAwX1NSKTsKICAJCQkJLyogY2hlY2sgZm9yIGFic2VudCBjb250
cm9sbGVyICovCiEgCQkJCWlmIChzdGF0dXMgPT0gMHhGRiAmJiBzamExMDAwX2lzX2Fic2VudChw
cml2KSkKICAJCQkJCXJldHVybiBJUlFfTk9ORTsKICAJCQl9CiAgCQl9CiAgCQlpZiAoaXNyYyAm
IChJUlFfRE9JIHwgSVJRX0VJIHwgSVJRX0JFSSB8IElSUV9FUEkgfCBJUlFfQUxJKSkgewogIAkJ
CS8qIGVycm9yIGludGVycnVwdCAqLwogIAkJCWlmIChzamExMDAwX2VycihkZXYsIGlzcmMsIHN0
YXR1cykpCiAgCQkJCWJyZWFrOwogIAkJfQotLS0gNTI2LDU1OSAtLS0tCiAgCQkJICAgICEoc3Rh
dHVzICYgU1JfVENTKSkgewogIAkJCQlzdGF0cy0+dHhfZXJyb3JzKys7CiAgCQkJCWNhbl9mcmVl
X2VjaG9fc2tiKGRldiwgMCk7CisgICAgICAgICBwcl9pbmZvKCJUWCBidWZmZXIgcmVsZWFzZWQu
XG4iKTsKICAJCQl9IGVsc2UgewogIAkJCQkvKiB0cmFuc21pc3Npb24gY29tcGxldGUgKi8KICAJ
CQkJc3RhdHMtPnR4X2J5dGVzICs9CiAgCQkJCQlwcml2LT5yZWFkX3JlZyhwcml2LCBTSkExMDAw
X0ZJKSAmIDB4ZjsKICAJCQkJc3RhdHMtPnR4X3BhY2tldHMrKzsKICAJCQkJY2FuX2dldF9lY2hv
X3NrYihkZXYsIDApOworICAgICAgICAgcHJfaW5mbygiVFggY29tcGxldGUuXG4iKTsKICAJCQl9
CiAgCQkJbmV0aWZfd2FrZV9xdWV1ZShkZXYpOwogIAkJCWNhbl9sZWRfZXZlbnQoZGV2LCBDQU5f
TEVEX0VWRU5UX1RYKTsKICAJCX0KICAJCWlmIChpc3JjICYgSVJRX1JJKSB7CiAgCQkJLyogcmVj
ZWl2ZSBpbnRlcnJ1cHQgKi8KKyAgICAgICBwcl9pbmZvKCJSZWNlaXZlZCBwYWNrZXQuXG4iKTsK
ICAJCQl3aGlsZSAoc3RhdHVzICYgU1JfUkJTKSB7CiAgCQkJCXNqYTEwMDBfcngoZGV2KTsKICAJ
CQkJc3RhdHVzID0gcHJpdi0+cmVhZF9yZWcocHJpdiwgU0pBMTAwMF9TUik7CiAgCQkJCS8qIGNo
ZWNrIGZvciBhYnNlbnQgY29udHJvbGxlciAqLwohIAkJCQlpZiAoc3RhdHVzID09IDB4RkYgJiYg
c2phMTAwMF9pc19hYnNlbnQocHJpdikpIHsKISAgICAgICAgICAgcHJfaW5mbygiSVJRIE5vbmUg
cnhcbiIpOwogIAkJCQkJcmV0dXJuIElSUV9OT05FOworICAgICAgICAgfQogIAkJCX0KICAJCX0K
ICAJCWlmIChpc3JjICYgKElSUV9ET0kgfCBJUlFfRUkgfCBJUlFfQkVJIHwgSVJRX0VQSSB8IElS
UV9BTEkpKSB7CiAgCQkJLyogZXJyb3IgaW50ZXJydXB0ICovCisgICAgICAgcHJfaW5mbygiRXJy
b3IgaW50ZXJydXB0LlxuIik7CiAgCQkJaWYgKHNqYTEwMDBfZXJyKGRldiwgaXNyYywgc3RhdHVz
KSkKICAJCQkJYnJlYWs7CiAgCQl9CioqKioqKioqKioqKioqKgoqKiogNTUxLDU1NiAqKioqCi0t
LSA1NjUsNTc1IC0tLS0KICAJaWYgKG4gPj0gU0pBMTAwMF9NQVhfSVJRKQogIAkJbmV0ZGV2X2Ri
ZyhkZXYsICIlZCBtZXNzYWdlcyBoYW5kbGVkIGluIElTUiIsIG4pOwogIAorICAgaWYgKG4pIHsK
KyAgICAgcHJfaW5mbygiUmV0dXJuaW5nIElSUV9IQU5ETEVEXG4iKTsKKyAgIH0gZWxzZSB7Cisg
ICAgIHByX2luZm8oIlJldHVybmluZyBJUlFfTk9ORVxuIik7CisgICB9CiAgCXJldHVybiAobikg
PyBJUlFfSEFORExFRCA6IElSUV9OT05FOwogIH0KICBFWFBPUlRfU1lNQk9MX0dQTChzamExMDAw
X2ludGVycnVwdCk7Cg==
--089e013c6e4abb9dac04ea9ed5f1--
