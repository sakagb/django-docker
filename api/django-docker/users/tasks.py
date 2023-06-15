from celery import shared_task
from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.translation import gettext_lazy as _


@shared_task(bind=True)
def notify_user(self, **kwargs):
    subject = _("Welcome to Django Docker!")
    email_from = settings.DEFAULT_FROM_EMAIL

    user = kwargs.get("user")

    recipient_list = [user.email]

    text_content = render_to_string(
        "emails/user.txt",
        {
            "user": user.username,
        },
    )
    html_content = render_to_string(
        "emails/user.html",
        {
            "user": user.username,
        },
    )
    msg = EmailMultiAlternatives(subject, text_content, email_from, recipient_list)
    msg.attach_alternative(html_content, "text/html")
    msg.send()
